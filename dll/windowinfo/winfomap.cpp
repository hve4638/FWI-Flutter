#include "winfomap.h"

using namespace std;

bool InfoMap::has(int key) {
	return (dict.find(key) != dict.end());
}

InfoMap::InfoMap() {
	counter = 0;
}

InfoMap::~InfoMap() {
	for (const auto& item : dict) {
		delete (item.second);
	}
}

int InfoMap::Create() {
	int key = counter++;
	dict.insert({ key, new WInfoActual() });

	return key;
}

bool InfoMap::Remove(int key) {
	if (has(key)) {
		WInfo *winfo = dict[key];
		dict.erase(key);

		delete winfo;
		return true;
	}
	else {
		return false;
	}
}

WInfo& InfoMap::operator[](int key) {
	if (has(key))
		return *(dict[key]);
	else
		return emptyinfo;
}