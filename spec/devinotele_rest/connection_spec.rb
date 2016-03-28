require 'spec_helper'

describe DevinoteleRest::Connection do

  it 'respond to get method' do
    expect(subject).to respond_to :get
  end

  it 'respond to post method' do
    expect(subject).to respond_to :post
  end
end
