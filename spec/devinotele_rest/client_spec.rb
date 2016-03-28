require 'spec_helper'

describe DevinoteleRest::Client do
  before do
    @login = :login
    @password = :password
    @connection = double(:connection)
    @session = double(:session, session_id: SecureRandom.uuid)
  end

  subject do
    DevinoteleRest::Client.new @login, @password
  end

  describe "#create" do
    before do
      allow(subject).to receive(:connection)
        .and_return(@connection)
      allow(subject).to receive(:session)
        .and_return(@session)
    end

    it 'send single message' do
      params = {
        from: :sender,
        to: 79999999999,
        body: "Test message"
      }
      expect(DevinoteleRest::Sms).to receive(:create)
        .with(params, @connection, @session.session_id).and_return(true)

      subject.create params
    end

    it 'send multiple messages' do
      params = {
        from: :sender,
        to: [79999999999],
        body: "Test message"
      }
      expect(DevinoteleRest::MultipleSms).to receive(:create)
        .with(params, @connection, @session.session_id).and_return(true)

      subject.create params
    end
  end

end
