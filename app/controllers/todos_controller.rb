class TodosController < ApplicationController
  before_filter :get_todo, :only => [:edit, :show, :update, :destroy]
  before_filter :signed_in_user, only: [:create, :destroy]  
  before_filter :correct_user,   only: :destroy

  def get_todo
    @todo = Todo.find_by_id(params[:id])
  end

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json  
  def create
    @todo = current_user.todos.build(params[:todo])
    respond_to do |format|
      if @todo.save
        flash[:success] = 'Todo was successfully created.' 
        format.html { redirect_to @todo }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        @feed_items = []
        format.html { render 'static_pages/home' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        flash[:success] = 'successfully updated'
        format.html { redirect_to @todo }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    def correct_user
      @todo = current_user.todos.find_by_id(params[:id])
      redirect_to root_url if @todo.nil?
    end  
end
