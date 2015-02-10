class CommonQuestions
  attr_reader :question, :answer, :slug

  def initialize(question, answer, slug)
    @question = question
    @answer = answer
    @slug = slug
  end

  def question
    @question
  end

  def answer
    @answer
  end
  
  def slug
    @slug
  end
end
