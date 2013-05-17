class UsersController < ApplicationController
  before_filter :get_user, only: [:edit, :show, :update, :destroy]
  before_filter :signed_in_user, only: [:edit, :index, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def get_user
    @user = User.find(params[:id])
  end

  # GET /users
  # GET /users.json
  def index
    # @users = User.all

    # provided by gem: paginate
    # ActiveRecord::Relation object returned by the paginate method added by the will_paginate gem 
    # to all Active Record objects
    @users = User.paginate(page: params[:page]) 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # paginate even works through the todos association, 
    # reaching into the todos table and pulling out the desired page of todos.
    @todos = @user.todos.paginate(page: params[:page])    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit   
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save 
        sign_in @user # doesn't sign in after sign up
        flash[:success] = "Welcome to My Todos!"       
        format.html { redirect_to @user }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        sign_in @user
        flash[:success] = "User successfully updated."
        format.html { redirect_to @user }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:success] = "User destroyed."

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end    

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    # not sure where this goes
    # def admin?
    #   current_user.admin == true
    # end
end
