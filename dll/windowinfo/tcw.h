#pragma once

#define API __declspec(dllexport)

extern "C" API const wchar_t* winfo_info(int);
extern "C" API int winfo_create();
extern "C" API int winfo_destroy(int key);
extern "C" API const wchar_t* winfo_title(int key);
extern "C" API const wchar_t* winfo_name(int key);
extern "C" API const wchar_t* winfo_path(int key);
extern "C" API const void* winfo_handle(int key);