/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	config.uiColor = '#F8F7F2';
	config.toolbar = [
		{name : 'clipboard', items:['Cut','Copy','Paste','-','Undo','Redo']},
		{name : 'basicstyles', items:['Bold', 'ltalic', 'Underline', 'Strike', '-', 'RemoveFormat']},
		{name : 'paragraph', items:['NumberedList', 'BulletedList','-', 'Outdent', 'Indent', '-', 
								'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBolck']},
		{name : 'insert', items:['Smiley','SpecialChar']},
		{name : 'styles', items:['Styles','Format','Font','FontSize']},
		{name : 'colors', items:['TextColor','BFColor']},
	];
};
