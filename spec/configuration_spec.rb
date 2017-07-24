require "spec_helper"
module Redex
  RSpec.describe "Configuration" do

    context "não definindo as configurações" do
      before do
        Redex.configuration do |config|
          config.secret_pv = 'admin'
        end
      end

      it "deve retornar as configurações setadas" do
        expect(Redex.secret_pv).to eq('admin')
        expect(Redex.secret_token).to be_nil
      end
    end

    context "definindo as configurações" do
      before do
        Redex.configuration do |config|
          config.secret_pv = 'admin'
          config.secret_token = 'mypass'
        end
      end

      it "deve retornar as configurações setadas" do
        expect(Redex.secret_pv).to eq('admin')
        expect(Redex.secret_token).to eq('mypass')
      end
    end
    
  end
end
