#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	Если Аналитика.Пустая() Тогда
		СоздатьАналитику();
	КонецЕсли; 
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	Если Состояние = Перечисления.ДБ_СостоянияЗадач.Выполнена Тогда
		//Задача выполнена, добавляем плановую сумму оплаты в планы
		//ДокументОбъект = Документы.Доходы.СоздатьДокумент();
		
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СоздатьАналитику()
	ИмяАналитики = Наименование;
	ВидАналитики = РегистрыСведений.ДБ_ЗначенияНастроекПрограммы.ДоступныеНастройки().ВидАналитикиЗадач;
	
	// Сначала пробуем найти аналитику
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ДополнительныеЗначенияВидовАналитик.Ссылка
		|ИЗ
		|	Справочник.ДополнительныеЗначенияВидовАналитик КАК ДополнительныеЗначенияВидовАналитик
		|ГДЕ
		|	ДополнительныеЗначенияВидовАналитик.Наименование = &Наименование
		|	И ДополнительныеЗначенияВидовАналитик.Владелец = &ВидАналитики";
	
	Запрос.УстановитьПараметр("Наименование", ИмяАналитики);
	Запрос.УстановитьПараметр("ВидАналитики", ВидАналитики);
	РезультатЗапроса = Запрос.Выполнить();
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Если ВыборкаДетальныеЗаписи.Следующий() Тогда
		Аналитика = ВыборкаДетальныеЗаписи.Ссылка;
	Иначе
		НоваяАналитика = Справочники.ДополнительныеЗначенияВидовАналитик.СоздатьЭлемент();
		НоваяАналитика.Наименование = ИмяАналитики;
		НоваяАналитика.Владелец = ВидАналитики;
		НоваяАналитика.Активность = Истина;
		НоваяАналитика.Записать();
		Аналитика = НоваяАналитика.Ссылка;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#КонецЕсли
