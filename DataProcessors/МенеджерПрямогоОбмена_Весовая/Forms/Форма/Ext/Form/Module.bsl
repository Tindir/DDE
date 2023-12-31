﻿
&НаСервере
Процедура МенеджерОбмена_Весовая_ОбновитьДанныеСтатусаОбъектаНаСервере()
	
	ДанныеУзлаПодключения = Получатель_ИмяУзла;
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	Прокси =  ОбработкаОбъект.ИнициализацияСоединения(ДанныеУзлаПодключения);
	
	ДанныеДляОтправки = ОбработкаОбъект.ПодготовитьДанныеДляОтправки_СтатусСостоянияУзла(Отправитель_ИмяУзла);
	Хранилище = Новый ХранилищеЗначения(ДанныеДляОтправки);
	
	хешИд = Отправитель_ИмяУзла.Код;
	  
	Результат = Прокси.MessageEx(хешИд, Хранилище, "Весовая_СтатусОбъекта");
	Результат = СериализаторXDTO.ПрочитатьXDTO(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура МенеджерОбмена_Весовая_ОбновитьДанныеСтатусаОбъекта(Команда)
	МенеджерОбмена_Весовая_ОбновитьДанныеСтатусаОбъектаНаСервере();
КонецПроцедуры

&НаСервере
Процедура МенеджерОбмена_Весовая_ОбменДаннымиНаСервере()
	
	ДанныеУзлаПодключения = Получатель_ИмяУзла;
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	Прокси = ОбработкаОбъект.ИнициализацияСоединения(ДанныеУзлаПодключения);
	
	ДанныеДляОтправки = ОбработкаОбъект.ПодготовитьДанныеДляОтправки_ДанныеДляОбмена(Отправитель_ИмяУзла);
	Хранилище = Новый ХранилищеЗначения(ДанныеДляОтправки);
	
	хешИд = Отправитель_ИмяУзла.Код;
	  
	Результат = Прокси.MessageEx(хешИд, Хранилище, "Весовая_ОбменДанными");
	Результат = СериализаторXDTO.ПрочитатьXDTO(Результат);
	
	ОбработкаОбъект.ВыполнитьОбработкуРезультата_ДанныеДляОбмена(Результат);
		
КонецПроцедуры

&НаКлиенте
Процедура МенеджерОбмена_Весовая_ОбменДанными(Команда)
	
	Режим = РежимДиалогаВопрос.ДаНет;
	Оповещение = Новый ОписаниеОповещения("МенеджерОбмена_Весовая_ОбменДаннымиЗавершение", ЭтотОбъект, Параметры);
	ПоказатьВопрос(Оповещение,  "Продолжить выполнение операции?", Режим, 0);
	
КонецПроцедуры

&НаКлиенте
Процедура МенеджерОбмена_Весовая_ОбменДаннымиЗавершение(Результат, Параметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Нет Тогда
        Возврат;
    КонецЕсли;

	МенеджерОбмена_Весовая_ОбменДаннымиНаСервере();

КонецПроцедуры