require 'spec_helper'

describe DevinoteleRest::Session do
  let(:login) { double(:login) }
  let(:password) { double(:password) }

  let(:session_id) { SecureRandom.uuid }
  let(:success_response) { double(:success_response, success?: true, body: session_id.inspect) }
  let(:connection) { double(:connection, get: success_response) }


  it 'responds to session_id' do
    session_r = DevinoteleRest::Session.new(login, password, connection)
    expect(session_r).to respond_to :session_id
  end

  context 'when login or password incorrect' do
    it 'raises error RequestError' do
      error_response = double(:error_response, success?: false, body: "{\"Code\":9,\"Desc\":\"Login or Password incorrect\"}")
      connection = double(:connection, get: error_response)

      expect{
        DevinoteleRest::Session.new('wrong_login', 'wrong_password', connection)
      }.to raise_error DevinoteleRest::RequestError
    end
  end

  context 'when login and password correct' do

    it 'returns session token' do
      session_r = DevinoteleRest::Session.new('right_login', 'right_password', connection)
      expect(session_r.session_id).to eql(session_id)
      expect{session_r.session_id}.not_to raise_error
    end
  end

  describe 'session validation' do
    it 'returns session valid status' do
      session_r = DevinoteleRest::Session.new('right_login', 'right_password', connection)
      expect(session_r.expired?).to be false
    end

    it 'returns session invalid status' do
      session_r = DevinoteleRest::Session.new('right_login', 'right_password', connection)
      Timecop.freeze(Time.now + 180 * 60)
      expect(session_r.expired?).to be true
      Timecop.return
    end
  end
end
