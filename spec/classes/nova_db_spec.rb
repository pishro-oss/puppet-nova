require 'spec_helper'

describe 'nova::db' do

  let :params do
    {}
  end

  shared_examples 'nova-db' do

    context 'with default parameters' do
      it { should_not contain_nova_config('database/connection') }
      it { should_not contain_nova_config('database/idle_timeout') }
    end

    context 'with overriden parameters' do
      before :each do
        params.merge!(
          :database_connection   => 'mysql://user:pass@db/db',
          :database_idle_timeout => '30',
        )
      end

      it { should contain_nova_config('database/connection').with_value('mysql://user:pass@db/db').with_secret(true) }
      it { should contain_nova_config('database/idle_timeout').with_value('30') }
    end

  end

  context 'on Debian platforms' do
    let :facts do
      { :osfamily => 'Debian' }
    end

    it_configures 'nova-db'
  end

  context 'on Redhat platforms' do
    let :facts do
      { :osfamily => 'RedHat' }
    end

    it_configures 'nova-db'
  end

end
