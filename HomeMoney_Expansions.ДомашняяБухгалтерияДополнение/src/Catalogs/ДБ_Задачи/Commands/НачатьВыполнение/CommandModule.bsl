
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Если ТипЗнч(ПараметрКоманды) = Тип("СправочникСсылка.ДБ_Задачи") И НЕ ПараметрКоманды.Пустая() Тогда
		ПараметрыФормы = Новый Структура("Задача", ПараметрКоманды);
		ОткрытьФорму("РегистрСведений.ДБ_Хронометраж.Форма.ФормаВыполненияЗадачи", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка,, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
КонецПроцедуры
