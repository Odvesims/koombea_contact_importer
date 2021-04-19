require 'rails_helper'
RSpec.describe ProcessFileWorker, type: :worker do
  describe "worker" do
    it "runs the worker" do
      expect(ProcessFileWorker.perform_async(129, ['name', 'date_of_birth', 'phone', 'address', 'credit_card', 'email'], )).to eq(true)
    end
  end
end
