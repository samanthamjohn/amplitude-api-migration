require 'spec_helper'

describe AmplitudeContext do
  describe "should_be_imported?" do
    context "the app version is not in the allowed types" do
      it "should return false" do
        amplitude_context = create(:context, app_version: "2.8.0")
        expect(amplitude_context.should_be_imported?).to be_false
      end
    end

    context "the os version is in the allowed types" do
      it "should return true" do
        amplitude_context = create(:context, app_version: "2.7.0.2")
        expect(amplitude_context.should_be_imported?).to be_true
      end
    end
  end
end
