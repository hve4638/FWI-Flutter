#include "pch.h"
#include <iostream>
#include <map>
#include "winfomap.h"
#include "resstr.h"
#include "tcw.h"

using namespace std;

InfoMap infomap;
ResultString result;

const wchar_t* winfo_info(int key) {
	switch (key) {
	case 0:
		return L"ABC";
	case 1:
		return L"¾È³ç";
	default:
		return L"unexpected";
	}
}

int winfo_create() {
	return infomap.Create();
}

int winfo_destroy(int key) {
	return infomap.Remove(key);
}

const wchar_t* winfo_title(int key) {
	WInfo *info = &infomap[key];
	wstring wstr = (info->GetTitle());
	result = wstr;

	return result.utf16();
}

const wchar_t* winfo_name(int key) {
	WInfo* info = &infomap[key];
	wstring wstr = info->GetName();
	result = wstr;

	return result.utf16();
}

const wchar_t* winfo_path(int key) {
	WInfo* info = &infomap[key];
	wstring wstr = info->GetPath();
	result = wstr;

	return result.utf16();
}

const void* winfo_handle(int key) {
	WInfo* info = &infomap[key];
	HWND hwnd = info->GetHandle();
	
	return (void*)hwnd;
}
/**/