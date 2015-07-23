require 'spec_helper'

describe DevinoteleRest::Connection do
  subject() { DevinoteleRest::Connection }

  it 'respond to create method' do
    expect(subject).to respond_to :create
  end
end
