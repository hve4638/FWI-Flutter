#pragma once
#include <map>
#include "windowinfo.h"

using namespace std;

class InfoMap {
private:
	int counter;
	map<int, WInfo*> dict;
	WInfoEmpty emptyinfo;

	bool has(int key);
public:
	InfoMap();
	~InfoMap();

	int Create();
	bool Remove(int key);

	WInfo& operator[](int key);
};