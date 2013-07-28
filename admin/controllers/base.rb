require 'rubygems'
require 'sinatra'
require 'fileutils'

Event::Admin.controllers :base do
  get :index, :map => "/" do
    render "base/index"
  end
end
