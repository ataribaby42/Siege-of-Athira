private _unit = _this select 0;

_unit createDiaryRecord ["Diary", [localize "STR_VersionTitle", format[localize "STR_Version", gVersion]]];
_unit createDiaryRecord ["Diary", [localize "STR_HowToPlayTitle", localize "STR_HowToPlay"]];
_unit createDiaryRecord ["Diary", [localize "STR_DiarySituationTitle", localize "STR_DiarySituation"]];