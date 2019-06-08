class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :redirect_questions, only: [:index, :show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    sleep 2.0

    end_counter = 10 # 受け付ける回答数
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        # question_idの値が@answer.question_idと同じasnwerの数を調べている
        num = Answer.where('question_id = ?', @answer.question_id).count
        # 回答数を調べ、10以上ならquestionのfinishをtrueにする
        if num >= end_counter
          q = Question.find @answer.question_id
          q.finished = true
          q.save
        end
        format.html { redirect_to '/questions/' + @answer.question_id.to_s }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    sleep 2.0
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:question_id, :content, :name)
    end

    # 新しく追加(リファクタリング)
    def redirect_questions
      redirect_to '/questions'
    end
end
