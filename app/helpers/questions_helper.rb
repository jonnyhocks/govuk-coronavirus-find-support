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
    return first_question if current_question == FILTER_QUESTION
    return FINAL_QUESTION if current_question == last_question

    current_question_index = questions_to_ask.index(current_question)
    questions_to_ask[current_question_index + 1]
  end

  def previous_question(current_question)
    return last_question if current_question == FINAL_QUESTION
    return FILTER_QUESTION if current_question == first_question

    current_question_index = questions_to_ask.index(current_question)
    questions_to_ask[current_question_index + -1]
  end

  def questions_to_ask
    session[:questions_to_ask]
  end

  def first_question
    questions_to_ask.first
  end

  def last_question
    questions_to_ask.last
  end

  def first_question_seen?
    session[:urgent_medical_help].present?
  end

  def last_question_seen?
    session[FINAL_QUESTION.to_sym].present?
  end

  def remove_questions(questions)
    updated_questions_to_ask = questions_to_ask
    questions.each do |question|
      updated_questions_to_ask.delete(question)
    end
    updated_questions_to_ask
  end

  def add_questions(questions, after_question)
    updated_questions_to_ask = questions_to_ask
    questions.each do |question|
      updated_questions_to_ask.insert(updated_questions_to_ask.index(after_question) + 1, question) unless updated_questions_to_ask.include?(question)
      after_question = question
    end
    updated_questions_to_ask
  end
end
