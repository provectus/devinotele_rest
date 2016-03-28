require 'spec_helper'

describe DevinoteleRest::Sms do
  let(:params) { { to: 'Number', from: 'Number', body: 'Text' } }
  let(:connection) { double(:connection) }
  let(:session_id) { SecureRandom.uuid }

  context 'when all credentials and balance is OK' do
    let(:success_response) { double('success_response', success?: true) }

    before do
      allow(connection).to receive(:post).and_return(success_response)
    end

    it 'sends sms' do
      expect{DevinoteleRest::Sms.create(params, connection, session_id)}.not_to raise_error
    end
  end

  context 'when sometimes goes wrong' do
    let(:error_response) { double('error_response', success?: false, body: "{\"Code\":9,\"Desc\":\"Some error message\"}") }

    before do
      allow(connection).to receive(:post).and_return(error_response)
    end

    it 'raises DevinoteleRest::RequestError' do
      expect{DevinoteleRest::Sms.create(params, connection, session_id)}.to raise_error DevinoteleRest::RequestError
    end
  end
end
