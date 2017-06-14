require 'spec_helper'

describe 'pound' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to compile.with_all_deps }

        context 'with defaults for all parameters' do
          it { is_expected.to contain_class('pound') }
          it { is_expected.to contain_class('pound::config') }
          it { is_expected.to contain_class('pound::install') }
          it { is_expected.to contain_class('pound::service') }
          it do
            is_expected.to contain_concat__fragment('00-header').with(
              target:  '/etc/pound.cfg',
              order:   '01',
              content: "#This file is managed by puppet\n"
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              target:  '/etc/pound.cfg',
              order:   '02',
              content: %r{User "nobody"}
            )
          end

          it do
            is_expected.to contain_concat('/etc/pound.cfg').with(
              owner: 'root',
              group: 'root',
              mode:  '0444'
            )
          end

          it do
            is_expected.to contain_file('/etc/pound').with(
              ensure:  'directory',
              owner:   'root',
              group:   'root',
              mode:    '0500',
              purge:   true,
              recurse: true
            )
          end

          it { is_expected.to contain_package('pound') }
          it { is_expected.to contain_service('pound') }
        end

        context 'specifying global params' do
          let(:params) do
            {
              user: '1adam12',
              group: 'one_adam_twelve',
              alive: 'dead',
              rootjail: 'alcatraz',
              pound_loglevel: 'some',
              pound_logfacility: 'cuckoos_nest',
              threads: 'some',
              ignorecase: 'camel',
              dynscale: 'static',
              client: 'master',
              timeout: 'never',
              connto: 'profrom',
              grace: 'wit',
              control: 'clarkson'
            }
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{User "1adam12"}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{Group "one_adam_twelve"}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{Alive dead}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{RootJail "alcatraz"}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{LogLevel some}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{LogFacility cuckoos_nest}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{Threads some}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{IgnoreCase camel}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{DynScale static}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{Client master}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{Timeout never}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{ConnTo profrom}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{Grace wit}
            )
          end

          it do
            is_expected.to contain_concat__fragment('01-globals').with(
              content: %r{Control "clarkson"}
            )
          end
        end

        context 'alternate package name' do
          let(:params) do
            {
              package_name: 'foo-package'
            }
          end

          it { is_expected.to contain_package('pound').with_name('foo-package') }
        end
      end
    end
  end
end
