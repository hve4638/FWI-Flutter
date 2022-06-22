#pragma once

#ifdef FWI_EXPORTS
#define FWI_API __declspec(dllexport)
#else
#define FWI_API __declspec(dllimport)
#endif

extern "C" FWI_API const wchar_t* fwi_info(int);
extern "C" FWI_API int fwi_create();
extern "C" FWI_API int fwi_destroy(int key);
extern "C" FWI_API const wchar_t* fwi_title(int key);
extern "C" FWI_API const wchar_t* fwi_name(int key);
extern "C" FWI_API const wchar_t* fwi_path(int key);
extern "C" FWI_API void* fwi_handle(int key);
