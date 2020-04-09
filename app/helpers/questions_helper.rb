module QuestionsHelper
  FINAL_QUESTION = "able_to_leave".freeze
  FILTER_QUESTION = "need_help_with".freeze

  def determine_user_questions(groups)
    if groups.empty?
      I18n.t("coronavirus_form.groups").map { |_, group| group[:questions].keys if group[:title] }.compact.flatten
    else
      questions_to_ask = groups.map do |group|
        I18n.t("coronavirus_form.groups.#{group}.questions").stringify_keys.keys
      end
      questions_to_ask.flatten.compact
    end
  end

  def next_question(current_question)
    return questions_to_ask.first if current_question == FILTER_QUESTION

    current_question_index = questions_to_ask.index(current_question)
    if current_question_index == (questions_to_ask.length - 1)
      FINAL_QUESTION
    else
      questions_to_ask[current_question_index + 1]
    end
  end

  def previous_question(current_question)
    return questions_to_ask.last if current_question == FINAL_QUESTION

    current_question_index = questions_to_ask.index(current_question)
    if current_question_index.zero?
      FILTER_QUESTION
    else
      questions_to_ask[current_question_index + -1]
    end
  end

  def questions_to_ask
    session[:questions_to_ask]
  end

  def first_question_seen?
    session[:urgent_medical_help].present?
  end
end