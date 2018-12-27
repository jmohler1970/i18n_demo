<?php
$i18n = array(
	# general
	'NAME' 			=> 		'Простые миниатюры',
	'DESCRIPTION' 	=> 		'Способствует регенерации миниатюр при необходимости.',
	# settings page
	'SETTINGS' 		=> 		'Простые миниатюры',
	'IWIDTH' 		=> 		'Ширина миниатюры',
	'IWIDTHDESC'	=>		'Установите максимальную ширину миниатюры в пикселях. Значение по умолчанию ',
	'IHEIGHT' 		=>		'Высота миниатюры',
	'IHEIGHTDESC'	=>		'Установить максимальную высоту миниатюры в пикселях. Значение по умолчанию 0 (auto).',
	'IWCUT'			=>		'Обрезать по ширине',
	'IWCUTDESC'		=>		'Установите ширину обрезания миниатюры. Значение по умолчанию равно 0 (не обрезать).',
	'IHCUT'			=>		'Обрезать по высоте',
	'IHCUTDESC'		=>		'Установите высоту обрезания миниатюры. Значение по умолчанию равно 0 (не обрезать).',
	'IQUALITY'		=>		'Качество изображения',
	'IQUALITYDESC'	=>		'Установите качество миниатюры в %. Значение по умолчанию 65%.',
	'BATCH'			=>		'Пакетная обработка изображений',
	'BATCHDESC'		=>		'Установить количество изображений, которые могут быть обработаны в одном пакете. Значение по умолчанию-50.',
	'INTRO'			=>		'Введение',
	'INSTRUCTIONS'	=>		'По умолчанию ширина миниатюры изменяется до значения, установленного в gsconfig.php.
							 Высота устанавливается в зависимости от ширины, так что если вы хотите указать для миниатюры максимальную высоту, используйте "Высота изображения".
							 Изображение для создания миниатюры не может быть уменьшено, а только обрезано от верхнего левого угла и размеры рассчитываются от первоначальных размеров изображения, а не миниатюры.
							 Качество изображения по умолчанию 65% установлено GetSimple. После того как настройки будут сохранены, вы можете найти кнопку "Регенерировать миниатюры" на вкладке Файлы.
							 Нажав на нее, все миниатюры в текущем каталоге будут созданы заново. Выберите нужную папку, чтобы регенерировать миниатюры, так как они обрабатываются только в одном каталоге.',
	
	# files page
	'REGENERATE'	=>		'Регенерировать миниатюры',
	'CFGERROR'		=>		'Отсутствует файл настроек!',
	'JSERROR'		=>		'Для работы этого плагина требуется JavaScript',
	'PROCESSING'	=>		'Обработка',
	'SUCCESS'		=>		'Успешно обработано',
	'THUMBNAILS'	=>		'миниатюры'
);