
#ifndef MODELICA_NDTABLE_C
#define MODELICA_NDTABLE_C

#ifndef _CRT_SECURE_NO_WARNINGS
#define _CRT_SECURE_NO_WARNINGS
#endif

#include "NDTable.h"
#include "NDTable.c"

#define NDTABLE_INTERPSTATUS_OK 0
#include "Interpolation.c"

#define MAX_LINE_LENGTH 4096
#define MAX_COLUMNS 100
#define NO_FILE_NAME "none"

static char* TY_strdup(const char* text)
{
	size_t len = 0;
	char* copy = NULL;

	if (!text)
	{
		return NULL;
	}

	len = strlen(text) + 1;
	copy = (char*)malloc(len);
	if (copy)
	{
		memcpy(copy, text, len);
	}

	return copy;
}

static void TY_normalize_slashes(char* path)
{
	char* p = path;

	if (!p)
	{
		return;
	}

	while (*p)
	{
		if (*p == '\\')
		{
			*p = '/';
		}
		p++;
	}
}

static FILE* TY_fopen_read(const char* file_name, char** resolved_name)
{
	FILE* file = NULL;
	char* path = NULL;
	char* source_file = NULL;
	char* resources_dir = NULL;
	const char* modelica_prefix = "modelica://Tables/";
	const char* file_prefix = "file:///";
	size_t prefix_len = 0;
	size_t root_len = 0;
	size_t rel_len = 0;

	if (resolved_name)
	{
		*resolved_name = NULL;
	}

	if (!file_name)
	{
		return NULL;
	}

	file = fopen(file_name, "r");
	if (file)
	{
		if (resolved_name)
		{
			*resolved_name = TY_strdup(file_name);
		}
		return file;
	}

	prefix_len = strlen(file_prefix);
	if (strncmp(file_name, file_prefix, prefix_len) == 0)
	{
		path = TY_strdup(file_name + prefix_len);
		if (path)
		{
			file = fopen(path, "r");
			if (file)
			{
				if (resolved_name)
				{
					*resolved_name = path;
				}
				else
				{
					free(path);
				}
				return file;
			}
			free(path);
		}
	}

	prefix_len = strlen(modelica_prefix);
	if (strncmp(file_name, modelica_prefix, prefix_len) == 0)
	{
		source_file = TY_strdup(__FILE__);
		if (source_file)
		{
			TY_normalize_slashes(source_file);
			resources_dir = strstr(source_file, "/Resources/C-Sources/");
			if (resources_dir)
			{
				root_len = (size_t)(resources_dir - source_file) + 1;
				rel_len = strlen(file_name + prefix_len);
				path = (char*)malloc(root_len + rel_len + 1);
				if (path)
				{
					memcpy(path, source_file, root_len);
					memcpy(path + root_len, file_name + prefix_len, rel_len + 1);
					file = fopen(path, "r");
					if (file)
					{
						if (resolved_name)
						{
							*resolved_name = path;
						}
						else
						{
							free(path);
						}
						free(source_file);
						return file;
					}
					free(path);
				}
			}
			free(source_file);
		}
	}

	return NULL;
}

// 需要将utf8转为多字节才增加的包含头文件
//#include <windows.h>

//NDTable_h TY_Modelica1DTable(
//	char* file_name,
//	int table_col,
//	int break1_col,
//	double* break1,
//	int break1_size,
//	double* table,
//	int table_size);

// 将utf8转为多字节函数
// char* UTF8ToMBCS(const char* utf8)
// {
//     int wlen = MultiByteToWideChar(CP_UTF8, 0, utf8, -1, 0, 0);
//     wchar_t* wbuf = (wchar_t*)malloc(wlen * 2);
//     MultiByteToWideChar(CP_UTF8, 0, utf8, -1, wbuf, wlen);
// 
//     int mblen = WideCharToMultiByte(CP_ACP, 0, wbuf, -1, 0, 0, 0, 0);
//     char* mb = (char*)malloc(mblen);
//     WideCharToMultiByte(CP_ACP, 0, wbuf, -1, mb, mblen, 0, 0);
// 
//     free(wbuf);
//     return mb;
// }

double abc(double a, double b)
{
	return a * b;
}


NDTable_h ModelicaNDTable_open(const int ndims, const double *data, const int size) {

	int rank, i, numel, dims[32];
	const double *scales[32];
	NDTable_h table = NULL;

	if (size < 2) {
		////ModelicaError("The number of elements in data must be >= 2 123");
		return NULL;
	}

	rank = *data++;

	// check the rank
	if (rank < 0 || rank > 32) {
		////ModelicaError("The first element in data must be in the range [0;32]");
		return NULL;
	}

	if (rank != ndims) {
		//ModelicaFormatError("The first element in data must match the number of inputs. Expected %d but was %d.", ndims, rank);
		return NULL;
	}

	// check the size
	if (size < 1 + rank) {
		////ModelicaError("Data has not enough elements for the given number of dimensions");
		return NULL;
	}

	// check the dimensions
	for (i = 0; i < rank; i++) {
		dims[i] = *data++;

		if (dims[i] < 1) {
			//ModelicaFormatError("The first element in data must match the number of inputs. %d.", dims[i]);
			//ModelicaError("The size of the dimensions must be >= 1");
			return NULL;
		}
	}

	// check the number of elements
	numel = 1;

	for (i = 0; i < rank; i++) {
		numel *= dims[i]; // data
	}

	for (i = 0; i < rank; i++) {
		numel += dims[i]; // scales
	}

	numel += rank; // dims
	numel++; // ndims

	if (size != numel) {
		//ModelicaFormatError("Data has the wrong number of elements for the given dimensions. Expected %d but was %d.", numel, size);
		return NULL;
	}

	for (i = 0; i < rank; i++) {
		scales[i] = data;
		data += dims[i];
	}

	table = NDTable_create_table(ndims, dims, data, scales);

	if (!table) {
		//ModelicaError(NDTable_get_error_message());
	}

	return table;
}

NDTable_h ModelicaNDTable_one(const int ndims, int x_size, double* x, int y_size, double* y)
{
	double vim = 1;
	int vim_size = 1;

	int data_size = 1 + 1 + y_size + x_size;
	double *data = (double*)malloc(data_size * sizeof(double));

	double x_size_double = (double)x_size;
	NDTable_h result;

	if (!data)
	{
		return NULL;
	}

	// Assemble the data block required by ModelicaNDTable_open.
	memcpy(data, &vim, sizeof(double));
	memcpy(data + 1, &x_size_double, sizeof(double));
	memcpy(data + 1 + 1, x, x_size * sizeof(double));
	memcpy(data + 1 + 1 + x_size, y, y_size * sizeof(double));

	//NDTable_h result = ModelicaNDTable_open(ndims, data, data_size);
	result = ModelicaNDTable_open(ndims, data, data_size);
	free(data);
	return result;
}

/*void ModelicaNDTable_close(NDTable_h externalTable) {

	NDTable_free_table(externalTable);

}*/

void ModelicaNDTable_close(void* externalTable) {
    
        NDTable_free_table((NDTable_h)externalTable);

}

double ModelicaNDTable_evaluate(
	NDTable_h table,
	int nparams,
	const double params[],
	NDTable_InterpMethod_t interp_method,
	NDTable_ExtrapMethod_t extrap_method) {

	double value = NAN;

	if (NDTable_evaluate(table, nparams, params, interp_method, extrap_method, &value)) {
		//ModelicaError(NDTable_get_error_message());
	}

	return value;
}

double ModelicaNDTable_evaluate_derivative(
	NDTable_h table,
	int nparams,
	const double params[],
	NDTable_InterpMethod_t interp_method,
	NDTable_ExtrapMethod_t extrap_method,
	const double delta_params[]) {

	double value = NAN;

	if (NDTable_evaluate_derivative(table, nparams, params, delta_params, interp_method, extrap_method, &value)) {
		//ModelicaError(NDTable_get_error_message());
	}

	return value;
}

double* GetDataFromCSVFile(char* file_name, int table_col, int* table_row)
{
	FILE* file = NULL;
	char line[MAX_LINE_LENGTH];
	char* token;
	double* column_data = NULL;
	double* resized = NULL;
	char* resolved_name = NULL;
	int column_count = 0;

	// Keep local declarations before executable statements for older C compilers.
	if (!table_row)
	{
		return NULL;
	}

	*table_row = 0;

	if (!file_name)
	{
		return NULL;
	}

	file = TY_fopen_read(file_name, &resolved_name);
	if (!file)
	{
		return NULL;
	}
	//char line[MAX_LINE_LENGTH];
	//char* token;
	//double* column_data = NULL;
	//int column_count = 0;

	// ���ж�ȡCSV�ļ�
	while (fgets(line, MAX_LINE_LENGTH, file) != NULL)
	{
		column_count = 0;
		token = strtok(line, ",");

		while (token != NULL && column_count < MAX_COLUMNS)
		{
			if (column_count == table_col - 1)
			{
				// �����ڴ沢��ָ���е����ݱ��浽������
				char* p = token;
				while (*p == ' ' || *p == '\r' || *p == '\n') p++;
				if (*p == '\0') break;
				if (column_data == NULL)
				{
					column_data = (double*)malloc(sizeof(double));
				}
				else
				{
					resized = (double*)realloc(column_data, (*table_row + 1) * sizeof(double));
					if (!resized)
					{
						free(column_data);
						fclose(file);
						*table_row = 0;
						return NULL;
					}
					column_data = resized;
				}

				if (!column_data)
				{
					fclose(file);
					*table_row = 0;
					return NULL;
				}

				column_data[*table_row] = atof(token);
				(*table_row)++;
				break;
			}
			column_count++;
			token = strtok(NULL, ",");
		}
	}
	fclose(file);
	free(resolved_name);
	return column_data;
}

int sum(int* bp_sizes, int ndims)
{
	int sizesum = 0;
	int i = 0;
	for (i = 0; i < ndims; i++)
	{
		sizesum += bp_sizes[i];
	}

	return sizesum;
}

int prod(int* bp_sizes, int ndims)
{
	int sizeprod = 1;
	int i = 0;
	for (i = 0; i < ndims; i++)
	{
		sizeprod *= bp_sizes[i];
	}

	return sizeprod;
}

NDTable_h TY_ModelicaNDTable(
	char* file_name,
	int table_col,
	int* break_cols,
	int ndims,
	double* breakpoints[],
	int* bp_sizes,
	double* table,
	int table_size)
{
	NDTable_h result = NULL;
	int offset = 0;
	int i = 0;
	int data_size = 0;
	double* data = NULL;
	double* first = NULL;
	int has_file = !streq(file_name, NO_FILE_NAME);
	//��ȡ����
	if (table_col > 0 && has_file)
	{
		table = GetDataFromCSVFile(file_name, table_col, &table_size);
		if (!table || table_size <= 0)
		{
			return NULL;
		}
	}

	for (i = 0; i < ndims; i++)
	{
		if (break_cols[i] > 0 && has_file)
		{
			breakpoints[i] = GetDataFromCSVFile(file_name, break_cols[i], &bp_sizes[i]);
			if (!breakpoints[i] || bp_sizes[i] <= 0)
			{
				if (table_col > 0)
				{
					free(table);
				}
				return NULL;
			}
		}
	}

	//��������ά�ȼ��
	if (prod(bp_sizes, ndims) != table_size)
	{
		free(data);
		if (has_file)
		{
			if (table_col > 0)
			{
				free(table);
			}

			for (i = 0; i < ndims; i++)
			{
				if (break_cols[i] > 0)
				{
					free(breakpoints[i]);
				}
			}
		}
		return NULL;
	}

	//ƴ������
	// CSV reading may update bp_sizes and table_size, so compute data_size after reading.
	data_size = 1 + ndims + sum(bp_sizes, ndims) + table_size;
	data = (double*)malloc(data_size * sizeof(double));
	if (!data)
	{
		if (has_file)
		{
			if (table_col > 0)
			{
				free(table);
			}

			for (i = 0; i < ndims; i++)
			{
				if (break_cols[i] > 0)
				{
					free(breakpoints[i]);
				}
			}
		}
		return NULL;
	}
	first = data;
	data[0] = (double)ndims;
	offset++;
	for (i = 0; i < ndims; i++)
	{
		data[offset] = (double)bp_sizes[i];
		offset++;
	}
	for (i = 0; i < ndims; i++)
	{
		memcpy(data + offset, breakpoints[i], bp_sizes[i] * sizeof(double));
		offset += bp_sizes[i];
	}
	memcpy(data + offset, table, table_size * sizeof(double));

	result = ModelicaNDTable_open(ndims, data, data_size);

	////�ͷ��ڴ�
	free(first);

	if (has_file)
	{
		if (table_col > 0)
		{
			free(table);
		}

		for (i = 0; i < ndims; i++)
		{
			if (break_cols[i] > 0)
			{
				free(breakpoints[i]);
			}
		}
	}

	return result;
}

NDTable_h TY_Modelica1DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 1;
	double* breakpoints[1] = { break1 };
	// 将utf8字符串转为多字节字符串
    //file_name = UTF8ToMBCS(file_name);
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica2DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 2;
	double* breakpoints[2] = { break1,break2 };
	// 将utf8字符串转为多字节字符串
    //file_name = UTF8ToMBCS(file_name);
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica3DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 3;
	double* breakpoints[3] = { break1,break2,break3 };
	// 将utf8字符串转为多字节字符串
    //file_name = UTF8ToMBCS(file_name);
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica4DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	double* break4,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 4;
	double* breakpoints[4] = { break1,break2,break3,break4 };
	// 将utf8字符串转为多字节字符串
    //file_name = UTF8ToMBCS(file_name);
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica5DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	double* break4,
	double* break5,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 5;
	double* breakpoints[5] = { break1,break2,break3,break4,break5 };
	// 将utf8字符串转为多字节字符串
    //file_name = UTF8ToMBCS(file_name);
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica6DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	double* break4,
	double* break5,
	double* break6,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 6;
	double* breakpoints[6] = { break1,break2,break3,break4,break5,break6 };
	// 将utf8字符串转为多字节字符串
    //file_name = UTF8ToMBCS(file_name);
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica7DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	double* break4,
	double* break5,
	double* break6,
	double* break7,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 7;
	double* breakpoints[7] = { break1,break2,break3,break4,break5,break6,break7 };
	// 将utf8字符串转为多字节字符串
    //file_name = UTF8ToMBCS(file_name);
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

#endif // MODELICA_NDTABLE_C
