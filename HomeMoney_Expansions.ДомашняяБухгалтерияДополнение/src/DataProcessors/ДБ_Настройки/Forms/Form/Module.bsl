
#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновитьИнтерфейс;

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КонстантыНаборДБ_ГруппаКонтактовПриИзменении(Элемент)
	Подключаемый_ПриИзмененииКонстанты(Элемент);
КонецПроцедуры

#Область КалендарьGoogle

&НаКлиенте
Процедура ДБ_ИспользоватьСинхронизациюСКалендаремGoogleПриИзменении(Элемент)
	Подключаемый_ПриИзмененииКонстанты(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура НаборКонстантДБ_GoogleClientIDПриИзменении(Элемент)
	Подключаемый_ПриИзмененииКонстанты(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура НаборКонстантДБ_GoogleClientSecretПриИзменении(Элемент)
	Подключаемый_ПриИзмененииКонстанты(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура НаборКонстантДБ_RefreshTokenПриИзменении(Элемент)
	Подключаемый_ПриИзмененииКонстанты(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура КонстантыНаборДБ_ИдентификаторКалендаряПриИзменении(Элемент)
	Подключаемый_ПриИзмененииКонстанты(Элемент);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура Подключаемый_ПриИзмененииКонстанты(Элемент, ОбновлятьИнтерфейс = Истина)
	КонстантаИмя = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	ОбновитьПовторноИспользуемыеЗначения();
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	Если КонстантаИмя <> "" Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	Результат = Новый Структура;
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	СохранитьЗначениеРеквизита(РеквизитПутьКДанным, Результат);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат Результат;
	
КонецФункции


&НаСервере
Процедура СохранитьЗначениеРеквизита(РеквизитПутьКДанным, Результат)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	Если РеквизитПутьКДанным = "" Тогда
		Возврат;
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 15)) = НРег("КонстантыНабор.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 16);
	Иначе
		// Определение имени и запись значения реквизита в соответствующей константе из "НаборКонстант".
		// Используется для тех реквизитов формы, которые связаны с константами напрямую (в отношении один-к-одному).
	КонецЕсли;
	
	// Сохранения значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = КонстантыНабор[КонстантаИмя];
		
		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;
			
		Если Не Результат.Свойство("ОповещениеФорм") Тогда
			Результат.Вставить("ОповещениеФорм", Новый Массив);
		ИначеЕсли ТипЗнч(Результат.ОповещениеФорм) = Тип("Структура") Тогда // Структуру в массив структур.
			ОповещениеФорм = Результат.ОповещениеФорм;
			Результат.ОповещениеФорм = Новый Массив;
			Результат.ОповещениеФорм.Добавить(ОповещениеФорм);
		КонецЕсли;
			
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	#Если НЕ ВебКлиент Тогда
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбновитьИнтерфейс();
	КонецЕсли;
	#КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура ПояснениеНастройкиСинхронизацииСсылкаОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	ЗапуститьПриложение("https://infostart.ru/1c/articles/1247448/");
КонецПроцедуры




#КонецОбласти
