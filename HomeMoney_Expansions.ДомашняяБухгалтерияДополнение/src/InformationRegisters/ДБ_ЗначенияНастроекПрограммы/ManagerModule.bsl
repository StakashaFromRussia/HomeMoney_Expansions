#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция ДоступныеНастройки() Экспорт
	МассивИменНастроек = ИменаНастроек();
	СтруктураНастроек = Новый Структура();
	Для Каждого ИмяНастройки Из МассивИменНастроек Цикл
		СтруктураНастроек.Вставить(ИмяНастройки, ЗначениеНастройки(ИмяНастройки));
	КонецЦикла;
	Возврат СтруктураНастроек;
КонецФункции

Функция ИменаНастроек() Экспорт
	МассивНастроек = Новый Массив;
	МассивНастроек.Добавить("Контакт_Заказчики");	
	МассивНастроек.Добавить("Контакт_Ученики");	
	
	МассивНастроек.Добавить("ВидАналитикиЗадач");	
	МассивНастроек.Добавить("ВидАналитикиЗаказчик");	
	
	МассивНастроек.Добавить("Кошелек_ДоходФриланс");
	
	МассивНастроек.Добавить("СтатьяДохода_Фриланс");
		
	Возврат МассивНастроек;
КонецФункции

Функция ЗначениеНастройки(ИмяНастройки) Экспорт
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ИмяНастройки = ИмяНастройки;
	МенеджерЗаписи.Прочитать();
	Если МенеджерЗаписи.Выбран() Тогда
		Значение = МенеджерЗаписи.ЗначениеНастройки.Получить();
		Возврат Значение;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


#КонецОбласти

#КонецЕсли
