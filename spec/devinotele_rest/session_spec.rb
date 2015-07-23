require 'spec_helper'

describe DevinoteleRest::Session do
  let(:login) { double() }
  let(:password) { double() }

  it 'responds to get_session' do
    session_r = DevinoteleRest::Session.new(login, password, double())
    expect(session_r).to respond_to :get_session
  end

  context 'when login or password incorrect' do
    let(:error_response) { double('error_response') }
    let(:connection) { double() }

    before do
      error_response.should_receive(:success?).and_return(false)
      error_response.should_receive(:body).and_return("{\"Code\":9,\"Desc\":\"Login or Password incorrect\"}")

      connection.should_receive(:get).and_return(error_response)
    end

    it 'raises error RequestError' do
      session_r = DevinoteleRest::Session.new('wrong_login', 'wrong_password', connection)
      expect{session_r.get_session}.to raise_error DevinoteleRest::RequestError
    end
  end

  context 'when login and password correct' do
    let(:success_response) { double('success_response') }
    let(:session_token) { SecureRandom.uuid }
    let(:connection) { double() }

    before do
      success_response.should_receive(:success?).twice.and_return(true)
      success_response.should_receive(:body).twice.and_return("\"#{session_token}\"")

      connection.should_receive(:get).twice.and_return(success_response)
    end

    it 'returns session token' do
      session_r = DevinoteleRest::Session.new('right_login', 'right_password', connection)
      expect(session_r.get_session).to eql(session_token)
      expect{session_r.get_session}.not_to raise_error
    end
  end
end
