require 'nubank'

RSpec.describe Nubank do
  subject { Nubank.new('<CPF>', '<PASSWORD>') }

  it 'has a version number' do
    expect(Nubank::VERSION).not_to be('0.1.0')
  end

  context '#services' do
    it 'has services urls available' do
      VCR.use_cassette :services do
        expect(subject.services).to include(
          'auth_device_resend_code',
          'auth_gen_certificates',
          'login',
          'pusher_auth_channel',
          'register_prospect',
          'register_prospect_global_web',
          'register_prospect_savings_mgm',
          'register_prospect_savings_web',
          'request_password_reset',
          'reset_password'
        )
      end
    end
  end

  context 'account api' do
    context '#account' do
      it 'shows account informations' do
        VCR.use_cassette(:account) do
          subject.login
          expect(subject.account).to include(
            '_links',
            'available_balance',
            'balances',
            'barcode_id',
            'cards',
            'created_at',
            'credit_limit',
            'current_balance',
            'current_interest_rate',
            'customer_id',
            'due_day',
            'effective_due_date',
            'future_balance',
            'id',
            'interest_rate',
            'limit_range_max',
            'limit_range_min',
            'net_available',
            'next_close_date',
            'next_due_date',
            'payment_method',
            'precise_credit_limit',
            'product_id',
            'request_id',
            'status',
            'temporary_limit_amount',
          )
        end
      end
    end

    context '#bills_summary' do
      it 'shows bills informations' do
        VCR.use_cassette(:bills_summary) do
          subject.login
          summary = subject.bills_summary
          expect(summary.first).to include('_links', 'state', 'summary')
          expect(summary.first['summary'].keys.sort).to include(
          'adjustments',
          'close_date',
          'due_date',
          'effective_due_date',
          'expenses',
          'fees',
          'interest',
          'interest_charge',
          'interest_rate',
          'interest_reversal',
          'international_tax',
          'minimum_payment',
          'open_date',
          'paid',
          'past_balance',
          'payments',
          'precise_minimum_payment',
          'precise_total_balance',
          'previous_bill_balance',
          'tax',
          'total_accrued',
          'total_balance',
          'total_credits',
          'total_cumulative',
          'total_financed',
          'total_international',
          'total_national',
          'total_payments',
          )
        end

        VCR.use_cassette(:logout) { subject.logout }
      end
    end

    context '#events' do
      it 'shows all events' do
        VCR.use_cassette(:events) do
          subject.login
          expect(subject.events.first).to include(
            '_links',
            'amount',
            'category',
            'description',
            'details',
            'href',
            'id',
            'time',
            'title'
          )
        end
        VCR.use_cassette(:logout) { subject.logout }
      end
    end

    context '#login' do
      it 'login user and make internal services available' do
        VCR.use_cassette(:login) do
          subject.login
          expect(subject.urls).to include(
            'change_password',
            'enabled_features',
            'certificate_status',
            'revoke_token',
            'userinfo',
            'events_page',
            'loginWebapp',
            'dropman',
            'events',
            'faq_push_back_state',
            'register_rewards',
            'login_webapp',
            'postcode',
            'app_flows',
            'rewards_signup_widget',
            'revoke_all',
            'customer',
            'account',
            'bills_summary',
            'features_map',
            'healthcheck',
            'savings_account',
            'rewards_enrollment',
            'purchases',
            'blackmirror',
            'ghostflame',
            'account_simple',
            'shore',
            'user_change_password'
          )
        end

        VCR.use_cassette(:logout) { subject.logout }
      end
    end
  end
end
