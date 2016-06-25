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

		$('form').on 'click', '.question-form-continue', (event) ->
			answerPanel = $(@).parent().parent().find('#add-answer-panel')
			audiencePanel = $(@).parent().parent().find('#audience-select-panel')
			questionHeader = $(@).parent().parent().find('.question-text')
			questionHeader.addClass("small")
			answerPanel.slideUp()
			audiencePanel.slideDown()

		$(".dismiss-question-show").click (event), ->
			questionShowPanel = $(@).parent()
			questionShowPanel.slideUp()

		$('form').on 'click', '#question-ask-submit-button', (event) ->
			answerPanel = $(@).parent().parent().find('#add-answer-panel')
			audiencePanel = $(@).parent().parent().find('#audience-select-panel')
			answerPanel.slideUp()
			audiencePanel.slideDown()

		$('form').on 'focusin', '#question-body', (event), ->
			alert("roast")
			question_ask_submit = $(@).parent().find('#question-ask-submit')
			question_ask_submit.show()

		$('form').on 'focusout', '#question-body', (event), ->
			questionText = $(@).val()
			if questionText.length == 0
				question_ask_submit = $(@).parent().find('#question-ask-submit')
				question_ask_submit.hide()
			end

		$("#question-ask-submit").click (event), ->
			filterPage = $(@).parent().find('.question-audience-filter')
			filterPage.show()
			event.preventDefault()

		$('form').on 'click', '.remove_fields', (event) ->
			$(this).prev('input[type=hidden]').val('1')
			$(this).closest('fieldset').hide()
			event.preventDefault()

		$('form').on 'click', '.add_fields', (event) ->
			time = new Date().getTime()
			regexp = new RegExp($(this).data('id'), 'g')
			$(this).before($(this).data('fields').replace(regexp, time))
			event.preventDefault()

