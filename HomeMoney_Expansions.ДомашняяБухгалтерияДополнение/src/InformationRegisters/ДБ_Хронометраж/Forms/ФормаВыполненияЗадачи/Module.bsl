
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("Задача", Задача) Тогда
		МенеджерЗаписи = РегистрыСведений.ДБ_Хронометраж.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.Задача = Задача;
		МенеджерЗаписи.Прочитать();
		Если МенеджерЗаписи.Выбран() Тогда
			ВремяНачала = МенеджерЗаписи.ДатаНачала;
		Иначе
			ВремяНачала = ТекущаяДатаСеанса();
		КонецЕсли;
		Активен = Истина;
		
		Элементы.Декорация_Часы.Заголовок = Формат(Дата(1, 1, 1), "ДЛФ=T");
		Элементы.Декорация_ТекущееВремя.Заголовок = Формат(ТекущаяДатаСеанса(), "ДЛФ=T");
		РегистрыСведений.ДБ_Хронометраж.НачалоВыполнения(Задача);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновлениеВремениВыполнения();
	ПодключитьОбработчикОжидания("ОбновлениеВремениВыполнения", 1);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если Активен Тогда
		ЗавершитьВыполнениеНаСервере(Задача);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьВыполнение(Команда)
	ЗавершитьВыполнениеНаСервере(Задача);
	Оповестить();
	Закрыть();
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗавершитьВыполнениеНаСервере(Задача)
	РегистрыСведений.ДБ_Хронометраж.ЗавершениеВыполнения(Задача);
КонецПроцедуры // ЗавершитьВыполнениеНаСервере(Задача)

#КонецОбласти

#Область Служебные

&НаКлиенте
Процедура ОбновлениеВремениВыполнения()
	КоличествоСекунд = ТекущаяДата() - ВремяНачала;
	Дата = Дата(1, 1, 1) + КоличествоСекунд;
	Элементы.Декорация_Часы.Заголовок = Формат(Дата, "ДЛФ=T");
КонецПроцедуры // ОбновлениеВремениВыполнения()

#КонецОбласти