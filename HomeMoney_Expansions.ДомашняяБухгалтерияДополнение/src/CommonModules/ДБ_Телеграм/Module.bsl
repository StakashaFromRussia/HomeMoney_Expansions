
#Область ПрограммныйИнтерфейс

Функция ОбработатьВходящийЗапрос(Запрос) Экспорт
	
	Секрет = Запрос.ПараметрыURL.Получить("secret");
	
	//Если Секрет <> Константы.СекретТелеграмБота.Получить() Тогда
	//	Ответ = Новый Структура;
	//	Ответ.Вставить("Result", "Error");
	//	Ответ.Вставить("ErrorText", "WrongSecret");
	//	Возврат ДБ_ОбщегоНазначенияHTTP.ОтветJSON(Ответ, 403);
	//КонецЕсли;	
	
	ДанныеЗапроса = ДанныеЗапроса(Запрос);
	
	Если ДанныеЗапроса.Свойство("message") Тогда
		Возврат ОбработатьСообщение(ДанныеЗапроса.message);
	КонецЕсли;
	
	Возврат ДБ_ОбщегоНазначенияHTTP.ПростойУспешныйОтвет();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОбработатьСообщение(ДанныеСообщения) 
	
	Если ДанныеСообщения.Свойство("from") Тогда
		ЗафиксироватьОтправителя(ДанныеСообщения.from);
	КонецЕсли;
	
	ИдентификаторЧата = ДанныеСообщения.chat.id;
	
	Если ДанныеСообщения.Свойство("text") Тогда
		ТекстСообщения = ДанныеСообщения.text;
	Иначе
		ТекстСообщения = "Пустое сообщение =(";
	КонецЕсли;
	
	ДанныеОтвета = Новый Структура;
	ДанныеОтвета.Вставить("method", "sendMessage");
	ДанныеОтвета.Вставить("chat_id", ИдентификаторЧата);
	
	Если ТекстСообщения = "СТАРТ" Тогда
		ДанныеОтвета.Вставить("text", "Выберите действие");
		ДанныеОтвета.Вставить("reply_markup", КлавиатураВыборДействия());
	ИначеЕсли ТекстСообщения = "ЗАПИСАТЬ ЗАНЯТИЕ" Тогда
		ДанныеОтвета.Вставить("text", "Введите данные в следующем виде: ""Занятие-ИмяУченика-КоличествоЧасов""");
	ИначеЕсли ТекстСообщения = "СОЗДАТЬ УЧЕНИКА" Тогда
		ДанныеОтвета.Вставить("text", "Введите данные в следующем виде: ""Создать-ИмяУченика-УровеньЯзыка-СтоимостьЧаса""");
		ДанныеОтвета.Вставить("reply_markup", "");
		
	ИначеЕсли СтрНайти(ТекстСообщения, ВРег("ЗАНЯТИЕ")) <> 0 Тогда
		
	ИначеЕсли СтрНайти(ТекстСообщения, ВРег("СОЗДАТЬ")) <> 0 Тогда
		МассивСтрок = СтрРазделить(ТекстСообщения, "-");
		//1. Команда
		//2. Имя ученика
		//3. Уровень языка
		//4. Стоимость часа
		
	Иначе
		ДанныеОтвета.Вставить("text", "Неизвестная команда. Нажмите ""СТАРТ""");
		ДанныеОтвета.Вставить("reply_markup", Клавиатура());
	КонецЕсли;
	
	Возврат ДБ_ОбщегоНазначенияHTTP.ОтветJSON(ДанныеОтвета);	
	
КонецФункции

Функция Клавиатура()
	
	СтрокиКлавиатуры = Новый Массив;
	КнопкиСтрокиКлавиатуры = Новый Массив;
	
	КнопкаКлавиатуры = Новый Структура;
	КнопкаКлавиатуры.Вставить("text", "СТАРТ");
	КнопкиСтрокиКлавиатуры.Добавить(КнопкаКлавиатуры);
	
	//КнопкаКлавиатуры = Новый Структура;
	//КнопкаКлавиатуры.Вставить("text", "Смайлик =)");
	//КнопкиСтрокиКлавиатуры.Добавить(КнопкаКлавиатуры);  
	
	СтрокиКлавиатуры.Добавить(КнопкиСтрокиКлавиатуры);
	
	ДанныеКлавиатуры = Новый Структура;
	ДанныеКлавиатуры.Вставить("keyboard", СтрокиКлавиатуры); 
	
	Возврат ДанныеКлавиатуры;
	
КонецФункции

Функция КлавиатураВыборДействия()
	
	СтрокиКлавиатуры = Новый Массив;
	КнопкиСтрокиКлавиатуры = Новый Массив;
	
	КнопкаКлавиатуры = Новый Структура;
	КнопкаКлавиатуры.Вставить("text", "ЗАПИСАТЬ ЗАНЯТИЕ");
	КнопкиСтрокиКлавиатуры.Добавить(КнопкаКлавиатуры);
	
	КнопкаКлавиатуры = Новый Структура;
	КнопкаКлавиатуры.Вставить("text", "СОЗДАТЬ УЧЕНИКА");
	КнопкиСтрокиКлавиатуры.Добавить(КнопкаКлавиатуры);  
	
	СтрокиКлавиатуры.Добавить(КнопкиСтрокиКлавиатуры);
	
	ДанныеКлавиатуры = Новый Структура;
	ДанныеКлавиатуры.Вставить("keyboard", СтрокиКлавиатуры); 
	
	Возврат ДанныеКлавиатуры;
	
КонецФункции

Функция ДанныеЗапроса(Запрос)
	
	ТелоЗапроса = Запрос.ПолучитьТелоКакСтроку();
	Возврат ДБ_ОбщегоНазначенияHTTP.ОбъектJSON(ТелоЗапроса);	
	
КонецФункции

Процедура ЗафиксироватьОтправителя(ДанныеОтправителя)
	
	Идентификатор = ДанныеОтправителя.id;
	
	УчетнаяЗапись = Справочники.ДБ_УчетныеЗаписиТелеграм.НайтиПоКоду(Идентификатор);
	
	Если ЗначениеЗаполнено(УчетнаяЗапись) Тогда
		Возврат;
	КонецЕсли;
	
	ЧастиИмениПользователя = Новый Массив;
	
	Если ДанныеОтправителя.Свойство("first_name") Тогда
		ЧастиИмениПользователя.Добавить(ДанныеОтправителя.first_name);
	КонецЕсли;
	
	Если ДанныеОтправителя.Свойство("last_name") Тогда
		ЧастиИмениПользователя.Добавить(ДанныеОтправителя.last_name);
	КонецЕсли;
	
	Если ДанныеОтправителя.Свойство("username") Тогда
		ЧастиИмениПользователя.Добавить(ДанныеОтправителя.username);
	КонецЕсли;        
	
	ИмяПользователя = СтрСоединить(ЧастиИмениПользователя, " ");
	
	СпрОбъект = Справочники.ДБ_УчетныеЗаписиТелеграм.СоздатьЭлемент();
	СпрОбъект.Наименование = ИмяПользователя;
	СпрОбъект.Код = Идентификатор;
	СпрОбъект.Записать();
	
КонецПроцедуры

#КонецОбласти