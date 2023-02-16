
Процедура ВводМесяцаПриИзменении(РедактируемыйОбъект, ПутьРеквизита, ПутьРеквизитаПредставления, Модифицированность = Ложь) Экспорт
	
	ЗначениеПредставления = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(РедактируемыйОбъект, ПутьРеквизитаПредставления);
	Значение              = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(РедактируемыйОбъект, ПутьРеквизита);
	
	ДатаКакМесяцПодобратьДатуПоТексту(ЗначениеПредставления, Значение);
	
	ПредставлениеМесяца = ДБ_ОбщегоНазначенияКлиентСервер.ПолучитьПредставлениеМесяца(Значение);
	ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(РедактируемыйОбъект, ПутьРеквизитаПредставления, ПредставлениеМесяца);
	ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(РедактируемыйОбъект, ПутьРеквизита, Значение);
	
	Модифицированность = Истина;
	
КонецПроцедуры 

Процедура ВводМесяцаНачалоВыбора(Форма, РедактируемыйОбъект, ПутьРеквизита, ПутьРеквизитаПредставления, ИзменитьМодифицированность = Истина, ОповещениеЗавершения = Неопределено, ЗначениеМесяцаПоУмолчанию = Неопределено) Экспорт
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Форма", Форма);
	ДополнительныеПараметры.Вставить("РедактируемыйОбъект", РедактируемыйОбъект);
	ДополнительныеПараметры.Вставить("ПутьРеквизита", ПутьРеквизита);
	ДополнительныеПараметры.Вставить("ПутьРеквизитаПредставления", ПутьРеквизитаПредставления);
	ДополнительныеПараметры.Вставить("ИзменитьМодифицированность", ИзменитьМодифицированность);
	ДополнительныеПараметры.Вставить("ОповещениеЗавершения", ОповещениеЗавершения);
	
	Значение = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(РедактируемыйОбъект, ПутьРеквизита);
	Если Значение <= '19000101' Тогда
		
		Если ЗначениеМесяцаПоУмолчанию = Неопределено Тогда
			Значение = НачалоМесяца(ДБ_ОбщегоНазначенияКлиент.ДатаСеанса());
		Иначе
			Значение = НачалоМесяца(ЗначениеМесяцаПоУмолчанию);
		КонецЕсли;
		
	КонецЕсли; 
	
	Оповещение = Новый ОписаниеОповещения("ВводМесяцаНачалоВыбораЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ОткрытьФорму("ОбщаяФорма.ВыборПериода", 
		Новый Структура("Значение,РежимВыбораПериода,ЗапрашиватьРежимВыбораПериодаУВладельца", Значение, "Месяц", Ложь),
		Форма, , , , Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ВводМесяцаРегулирование(РедактируемыйОбъект, ПутьРеквизита, ПутьРеквизитаПредставления, Направление, Модифицированность = Ложь, ЗначениеМесяцаПоУмолчанию = Неопределено) Экспорт
	
	Значение = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(РедактируемыйОбъект, ПутьРеквизита);
	
	Если Значение <= '19000101' Тогда
		
		Если ЗначениеМесяцаПоУмолчанию = Неопределено Тогда
			Значение = НачалоМесяца(ОбщегоНазначенияКлиент.ДатаСеанса());
		Иначе
			Значение = НачалоМесяца(ЗначениеМесяцаПоУмолчанию);
		КонецЕсли;
		
		НовоеЗначение = Значение;
		
	Иначе
		НовоеЗначение = ДобавитьМесяц(Значение, Направление);
	КонецЕсли; 
	
	Если НовоеЗначение >= '00010101' Тогда
		
		Значение = НовоеЗначение;
		
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(РедактируемыйОбъект, ПутьРеквизита, Значение);
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(РедактируемыйОбъект, ПутьРеквизитаПредставления, ДБ_ОбщегоНазначенияКлиентСервер.ПолучитьПредставлениеМесяца(Значение));
		
		Модифицированность = Истина;
	 	
	КонецЕсли;
	
КонецПроцедуры 
 
Процедура ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка) Экспорт
	
	Если Не ПустаяСтрока(Текст) Тогда
		ДанныеВыбора = ДатаКакМесяцПодобратьДатуПоТексту(Текст);
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

Процедура ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка) Экспорт
	
	Если Текст <> "" Тогда
		ДанныеВыбора = ДатаКакМесяцПодобратьДатуПоТексту(Текст);
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

Функция ДатаКакМесяцПодобратьДатуПоТексту(Текст, ДатаПоТексту = НеОпределено)
	
	СписокВозврата = Новый СписокЗначений;
	ТекущийГод = Год(ДБ_ОбщегоНазначенияКлиент.ДатаСеанса());
	
	Если ПустаяСтрока(Текст) Тогда
		ДатаПоТексту = Дата(1, 1, 1);
		Возврат СписокВозврата;
	КонецЕсли;
	
	Если СтрНайти(Текст, ".") <> 0 Тогда
		Подстроки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Текст, ".");
	ИначеЕсли СтрНайти(Текст, ",") <> 0 Тогда
		Подстроки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Текст, ",");
	ИначеЕсли СтрНайти(Текст, "-") <> 0 Тогда
		Подстроки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Текст, "-");
	ИначеЕсли СтрНайти(Текст, "/") <> 0 Тогда
		Подстроки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Текст, "/");
	ИначеЕсли СтрНайти(Текст, "\") <> 0 Тогда
		Подстроки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Текст, "\");
	Иначе
		Подстроки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(Текст, " ");
	КонецЕсли;
	
	Если Подстроки.Количество() = 1 Тогда
		
		Если СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(Текст) Тогда
			МесяцЧислом = Число(Текст);
			Если МесяцЧислом >= 1 И МесяцЧислом <=12 Тогда
				ДатаПоТексту = Дата(ТекущийГод, МесяцЧислом, 1);
				Если СтрДлина(Текст) = 1 Тогда
					СписокВозврата.Добавить(Формат(ДатаПоТексту, "ДФ='М/гг'"));
				Иначе
					СписокВозврата.Добавить(Формат(ДатаПоТексту, "ДФ='ММ/гг'"));
				КонецЕсли;
			Иначе
				Возврат СписокВозврата;
			КонецЕсли;                
		Иначе
			СписокМесяцев = СписокМесяцевПоСтроке(Текст);
			Для Каждого Месяц Из СписокМесяцев Цикл
				ДатаПоТексту = Дата(ТекущийГод, Месяц, 1);
				СписокВозврата.Добавить(Формат(ДатаПоТексту, "ДФ='ММММ гггг'"));
			КонецЦикла;
		КонецЕсли;
		
	ИначеЕсли Подстроки.Количество() = 2 Тогда
		
		Если СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(Подстроки[1]) Тогда
			
			Если ПустаяСтрока(Подстроки[1]) Тогда
				ГодЧислом = 0;
				Подстроки[1] = "0";
				ТекстВозврата = Текст + "0";
			Иначе
				ГодЧислом = Число(Подстроки[1]);
				ТекстВозврата = "";
			КонецЕсли;
			
			Если ГодЧислом > 3000 Тогда
				Возврат СписокВозврата;
			КонецЕсли;
			
			Если СтрДлина(Подстроки[1]) <= 1 Тогда
				ГодЧислом = Число(Лев(Формат(ТекущийГод, "ЧГ="), 3) + Подстроки[1]);
			ИначеЕсли СтрДлина(Подстроки[1]) = 2 Тогда
				ГодЧислом = Число(Лев(Формат(ТекущийГод, "ЧГ="), 2) + Подстроки[1]);
			ИначеЕсли СтрДлина(Подстроки[1]) = 3 Тогда
				ГодЧислом = Число(Лев(Формат(ТекущийГод, "ЧГ="), 1) + Подстроки[1]);
			ИначеЕсли СтрДлина(Подстроки[1]) = 4 Тогда
				ГодЧислом = Число(Подстроки[1]);
			КонецЕсли;                    
			
		Иначе
			
			Возврат СписокВозврата;
			
		КонецЕсли;                
		Если ЗначениеЗаполнено(Подстроки[0]) И СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(Подстроки[0]) Тогда
			
			МесяцЧислом = Число(Подстроки[0]);
			Если МесяцЧислом >= 1 И МесяцЧислом <= 12 Тогда
				ДатаПоТексту = Дата(ГодЧислом, МесяцЧислом, 1);
				СписокВозврата.Добавить(Формат(ДатаПоТексту, "ДФ='ММММ гггг'"));
			Иначе
				Возврат СписокВозврата;
			КонецЕсли;                
			
		Иначе
			
			СписокМесяцев = СписокМесяцевПоСтроке(Подстроки[0]);
			
			Если СписокМесяцев.Количество() = 1 Тогда
				ДатаПоТексту = Дата(ГодЧислом, СписокМесяцев[0], 1);
				СписокВозврата.Добавить(Формат(ДатаПоТексту, "ДФ='ММММ гггг'"));
			Иначе
				Для Каждого Месяц Из СписокМесяцев Цикл
					ДатаПоТексту = Дата(ГодЧислом, Месяц, 1);
					СписокВозврата.Добавить(Формат(Дата(ГодЧислом, Месяц, 1), "ДФ='ММММ гггг'"));
				КонецЦикла;
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
	Возврат СписокВозврата;
	
КонецФункции

// Подбирает массив номеров месяцев, соответствующих переданной строке
// например, для строки "ма" это будут 3 и 5, для "а" - 4 и 8
// используется в ПодобратьДатуПоТексту.
//
Функция СписокМесяцевПоСтроке(Текст)
	
	СписокМесяцев  = Новый СписокЗначений;
	Месяцы         = Новый Соответствие;
	МесяцыВозврата = Новый Массив;
	
	Для Счетчик = 1 По 12 Цикл
		Представление = Формат(Дата(2000, Счетчик, 1), "ДФ='ММММ'");
		СписокМесяцев.Добавить(Счетчик, Представление);
		Представление = Формат(Дата(2000, Счетчик, 1), "ДФ='МММ'");
		СписокМесяцев.Добавить(Счетчик, Представление);
	КонецЦикла;
	
	Для Каждого ЭлементСписка Из СписокМесяцев Цикл
		Если ВРег(Текст) = ВРег(Лев(ЭлементСписка.Представление, СтрДлина(Текст))) Тогда
			Месяцы[ЭлементСписка.Значение] = 0;
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Элемент Из Месяцы Цикл
		МесяцыВозврата.Добавить(Элемент.Ключ);
	КонецЦикла;
	
	Возврат МесяцыВозврата;
	
КонецФункции
