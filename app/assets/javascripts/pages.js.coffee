# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	
	jQuery ->

		$('form').on 'click', '.question-binary-option.inactive', (event) ->
			sisterButton = $(@).parent().find('.active')
			$(@).removeClass("inactive")
			$(@).addClass("active")
			sisterButton.removeClass("active")
			sisterButton.addClass("inactive")

		$('form').on 'click', '#question-binary-option-male', (event) ->
			radio_button_male = $(@).parent().parent().nextAll('#gender-radio-button-male')
			radio_button_male.prop("checked", true)

		$('form').on 'click', '#question-binary-option-female', (event) ->
			radio_button_female = $(@).parent().parent().nextAll('#gender-radio-button-female')
			radio_button_female.prop("checked", true)

		$('form').on 'focusin', '#question_body', (event), ->
			question_ask_submit = $(@).parent().find('#question-ask-submit')
			question_ask_submit.show()

		$('form').on 'focusout', '#question_body', (event), ->
			questionText = $(@).val()
			if questionText.length == 0
				question_ask_submit = $(@).parent().find('#question-ask-submit')
				question_ask_submit.slideUp()
			end