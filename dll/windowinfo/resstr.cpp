#include "resstr.h"

#define CONVERT_STRING(from, to) to.assign(from.begin(), from.end())

ResultString::ResultString() {
	type = NONE;
}

const char* ResultString::operator=(const char* src) {
	str = src;
	type = STR;

	return src;
}

string& ResultString::operator=(string& src) {
	str = src;
	type = STR;

	return src;
}

wstring& ResultString::operator=(wstring& src) {
	wstr = src;
	type = WSTR;

	return src;
}
const wchar_t* ResultString::operator=(const wchar_t* src) {
	wstr = src;
	type = WSTR;

	return src;
}

const char* ResultString::c_str() {
	switch (type) {
	case STR:
		break;

	case WSTR:
		CONVERT_STRING(wstr, str);

	case NONE:
		str = "";
	}

	return str.c_str();
}

const wchar_t* ResultString::utf16() {
	switch (type) {
	case STR:
		CONVERT_STRING(str, wstr);

	case WSTR:
		break;

	case NONE:
		wstr = L"";
	}

	return wstr.c_str();
}
