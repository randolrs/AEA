# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

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
				answersContainer = $(@).parent().find('.answer-container')
				questionShowPanel.hide()
				answersContainer.html("")

			$(".return-to-dashboard").click (event), ->
				questionShowPanel = $(@).parent().parent()
				answersContainer = questionShowPanel.find('.answer-container')
				questionShowPanel.hide()
				answersContainer.html("")

			$('form').on 'click', '#question-ask-submit-button', (event) ->
				answerPanel = $(@).parent().parent().find('#add-answer-panel')
				audiencePanel = $(@).parent().parent().find('#audience-select-panel')
				answerPanel.slideUp()
				audiencePanel.slideDown()

			$('form').on 'focusin', '#question-body', (event), ->
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
				inputQuestion = $(@).parent().find('input.question-text')
				filterPageHeader = filterPage.find('textarea.question-text')
				filterPageHeader.text(inputQuestion.val())
				filterPage.slideDown()
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

			$("li.question-show-link").click (event), ->
				returnQuestionDetails = $(@).parent().parent().parent().parent().parent().parent().find('.return-question-details')
				answersContainer = returnQuestionDetails.find('.answer-container')
				questionID = $(@).attr('id')
				$.ajax
					url: "/questions/details/#{questionID}", format: 'js'
					type: "GET"
					success: (data) ->
						console.log(data)
						notice = data.notice
						if notice.length > 0
							alert(notice)
						else
							questionBody = data.body
							answersHTML = data.answers_html
							questionHeader = returnQuestionDetails.find('.return-question-details-header')
							questionHeader.text(questionBody)
							answersContainer.append(answersHTML)
							returnQuestionDetails.slideDown()
							numberOfAnswers = data.answer_count
							answer_1_count = data.answer_1_count
							answer_2_count = data.answer_2_count
							answer_3_count = data.answer_3_count
							answer_4_count = data.answer_4_count

			$('a.answer-field').click (event) ->
				responsePanel = $(@).parent().parent()
				questionID = responsePanel.attr('id')
				answerID = $(@).attr('id')
				$.ajax
					url: "/question/response/#{questionID}/#{answerID}", format: 'js'
					type: "GET"
					success: (data) ->
						if data.successful
							responsePanel.slideUp()
						else
							responsePanel.hide()

$(document).ready(ready)
$(document).on('page:load', ready)
