
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ДБ_ПоказанияСчетчиков 
	Движения.ДБ_ПоказанияСчетчиков.Записывать = Истина;
	Для Каждого ТекСтрокаПоказания Из Показания Цикл
		Движение = Движения.ДБ_ПоказанияСчетчиков.Добавить();
		Движение.Период = Дата;
		Движение.Имущество = Имущество;
		Движение.Счетчик = ТекСтрокаПоказания.Счетчик;
		Движение.Количество = ТекСтрокаПоказания.Показание;
	КонецЦикла;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
