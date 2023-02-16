
#Область ПрограммныйИнтерфейс

Функция СтрокаJSON(ОбъектJSON) Экспорт
	
	ПараметрыЗаписи = Новый ПараметрыЗаписиJSON(, Символы.Таб);
	
	Запись = Новый ЗаписьJSON;
	Запись.УстановитьСтроку(ПараметрыЗаписи);
	ЗаписатьJSON(Запись, ОбъектJSON);
	
	Возврат Запись.Закрыть();
	
КонецФункции

Функция ОбъектJSON(СтрокаJSON) Экспорт
	
	Чтение = Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(СтрокаJSON);
	ОбъектJSON = ПрочитатьJSON(Чтение);
	Чтение.Закрыть();
	
	Возврат ОбъектJSON;	
	
КонецФункции

Функция ОтветJSON(Объект, КодСостояния = 200) Экспорт
	
	Ответ = Новый HTTPСервисОтвет(КодСостояния);
	
	Ответ.УстановитьТелоИзСтроки(СтрокаJSON(Объект));
	Ответ.Заголовки.Вставить("Content-Type", ТипКонтентаJSON());
	
	Возврат Ответ;
	
КонецФункции

Функция ПростойУспешныйОтвет() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Result", "Ok");
	
	Возврат ОтветJSON(Результат);
	
КонецФункции

Функция ОтветОбОшибке(ИнформацияОбОшибке) Экспорт
	
	ЗаписьЖурналаРегистрации("HTTPСервисы.Ошибка", УровеньЖурналаРегистрации.Ошибка,,,
		ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
	
	Результат = Новый Структура;
	Результат.Вставить("Result", "Error");
	Результат.Вставить("ErrorText", КраткоеПредставлениеОшибки(ИнформацияОбОшибке));
	
	Возврат ОтветJSON(Результат, 500);
	
КонецФункции

Процедура ЗаписьЛога(ИмяМетода, Запрос, Ответ) Экспорт
	
	ДокОбъект = Документы.ДБ_ВходящийHTTPЗапрос.СоздатьДокумент();
	ДокОбъект.ИмяМетода = ИмяМетода; 
	ТелоЗапроса = Запрос.ПолучитьТелоКакСтроку();	
	Попытка
		ТелоЗапроса = СтрокаJSON(ОбъектJSON(ТелоЗапроса));
	Исключение
	КонецПопытки;
	ДокОбъект.ТелоЗапроса = ТелоЗапроса;
	ДокОбъект.ТелоОтвета = Ответ.ПолучитьТелоКакСтроку();
	ДокОбъект.КодСостояния = Ответ.КодСостояния;
	ДокОбъект.Дата = ТекущаяДатаСеанса();
	
	ДокОбъект.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ТипКонтентаJSON()
	Возврат "application/json";
КонецФункции

#КонецОбласти