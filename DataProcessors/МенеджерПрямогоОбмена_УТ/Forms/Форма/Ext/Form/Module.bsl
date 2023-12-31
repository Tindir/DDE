﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Контрагент = Справочники.Контрагенты.ПустаяСсылка();
	ДоговорКонтрагента = Справочники.ДоговорыКонтрагентов.ПустаяСсылка();
	
КонецПроцедуры

&НаСервере
Процедура ОтправитьДокументСписаниеТМЦНаСервере()
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	Результат = ОбработкаОбъект.ВыполнитьОтправку_СписаниеТМЦ(ДокументСсылка, "ЦПЗ_БП");
	
	Если Результат.Отказ = Ложь Тогда
		
		ДокументОбъект = ДокументСсылка.ПолучитьОбъект();
		ДокументОбъект.ДокументСкладскогоУчетаГУИД = Результат.Результат.ДокументСкладскогоУчетаГУИД;
		ДокументОбъект.ДокументУчетаВЭксплуатацииГУИД = Результат.Результат.ДокументУчетаВЭксплуатацииГУИД;
		
		ДокументОбъект.Записать(РежимЗаписиДокумента.Запись);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьДокументСписаниеТМЦ(Команда)
	ОтправитьДокументСписаниеТМЦНаСервере();
КонецПроцедуры


&НаСервере
Процедура ОтправитьКонтрагентВзаиморасчетыНаСервере()
	
	ПараметрыЗапроса = новый Структура("ТаблицаДанных, ДатаОстатка",,ТекущаяДата());
	
	КонтрагентыВзаиморасчеты = новый Массив;
	КонтрагентыВзаиморасчеты.Добавить(новый Структура("Контрагент, ДоговорКонтрагента", Контрагент, ДоговорКонтрагента));
	
	ПараметрыЗапроса.Вставить("ТаблицаДанных", КонтрагентыВзаиморасчеты); 
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	Результат = ОбработкаОбъект.ВыполнитьОтправку_Контрагент_Взаиморасчеты(ПараметрыЗапроса, "ЦПЗ_БП");
	
	Если Результат.Отказ = Ложь Тогда
		
		Сообщить("Данные получены");
				
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьКонтрагентВзаиморасчеты(Команда)
	ОтправитьКонтрагентВзаиморасчетыНаСервере();
КонецПроцедуры


