# Лабораторная 1

Освоение ООП в Swift.

___

1. Придумайте архитектуру для подсказок поисковой строки. 
Подсказки бывают с текстом, ссылкой, картинкой и 
сочетанием нескольких вариантов. У каждой подсказки должен быть id.

    Всего у нас может быть семь вариаций:
    
    - Текст
    - Картинка  
    - Ссылка  
    - Текст + картинка  
    - Текст + ссылка  
    - Картинка + ссылка  
    - Текст + картинка + ссылка  

2. Сделайте протоколы для всех видов подсказок и их сочетаний.

3. Сделайте протокол класса, выдающего подсказки. 
Подразумевается, что на любую строку есть хотя бы одна подсказка. 
Он должен инициализироваться от строки (строка -- константа), 
подбирать подсказки, возвращать количество подсказок и любую из подсказок.

4. Сделайте расширение на любой протокол.

5. Реализуйте по объекту на каждый протокол

6. Реализуйте класс, выдающий подсказки и продемонстрируйте его функционал.
