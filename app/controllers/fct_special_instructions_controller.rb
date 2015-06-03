class FctSpecialInstructionsController < ApplicationController


  def show
   @fct_special_instructions = FctSpecialInstructions.find(params[:order_number])


  end


  def index
    @fct_special_instructions = FctSpecialInstructions.search(params[:search], params[:page])

  end
  

  end