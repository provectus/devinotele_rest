require 'spec_helper'

describe DevinoteleRest::Sms::Create do
  let(:options) { { to: 'Number', from: 'Number', body: 'Text' } }
  let(:connection) { double('conn') }
  let(:session) { SecureRandom.uuid }

  context 'when all credentials and balance is OK' do
    let(:success_response) { double('success_response') }

    before do
      success_response.should_receive(:success?).and_return(true)
      connection.should_receive(:post).and_return(success_response)
    end

    it 'sends sms' do
      expect{DevinoteleRest::Sms::Create.create(options, connection, session)}.not_to raise_error
    end
  end

  context 'when sometimes goes wrong' do
    let(:error_response) { double('error_response') }

    before do
      error_response.should_receive(:success?).and_return(false)
      error_response.should_receive(:body).and_return("{\"Code\":9,\"Desc\":\"Some error message\"}")
      connection.should_receive(:post).and_return(error_response)
    end

    it 'raises DevinoteleRest::RequestError' do
      expect{DevinoteleRest::Sms::Create.create(options, connection, session)}.to raise_error DevinoteleRest::RequestError
    end
  end
end
