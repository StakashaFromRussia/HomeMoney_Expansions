
Функция PingGETPing(Запрос)
	Возврат ДБ_ОбщегоНазначенияHTTP.ПростойУспешныйОтвет();
КонецФункции

Функция SendPOSTSend(Запрос)
	
	УстановитьПривилегированныйРежим(Истина);
	Попытка                                
		Ответ = ДБ_Телеграм.ОбработатьВходящийЗапрос(Запрос);
	Исключение  
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		Ответ = ДБ_ОбщегоНазначенияHTTP.ОтветОбОшибке(ИнформацияОбОшибке);
	КонецПопытки;
	
	ДБ_ОбщегоНазначенияHTTP.ЗаписьЛога("send", Запрос, Ответ);
	
	Возврат Ответ;
	
КонецФункции
