_result = format ["%2/%3/%1", _this select 0, _this select 1, _this select 2];

switch (language) do {
	case "English": { _result = format ["%2/%3/%1", _this select 0, _this select 1, _this select 2]; };
	case "Czech": { _result = format ["%3. %2. %1", _this select 0, _this select 1, _this select 2]; };
};

_result