require 'spec_helper'

describe 'pound::https' do
  context 'with defaults' do
    let(:title) { 'foo' }
    let(:params) do
      { cert: '/tmp/foo.crt' }
    end

    it do
      is_expected.to contain_concat__fragment('https_server-foo').with(
        order: '20-foo',
        target: '/etc/pound.cfg',
        content: %r{Cert "/tmp/foo.crt"}
      )
    end
  end

  context 'with multiple backends' do
    let(:title) { 'double_double' }
    let(:params) do
      {
        cert: '/tmp/foo.crt',
        backend: { '127.0.0.1' => 80, '192.168.1.1' => 90 }
      }
    end

    it do
      is_expected.to contain_concat__fragment('https_server-double_double').with(
        content: %r{BackEnd\n    Address 192.168.1.1}
      )
    end

    it do
      is_expected.to contain_concat__fragment('https_server-double_double').with(
        content: %r{BackEnd\n    Address 127.0.0.1}
      )
    end
  end

  context 'with all options' do
    let(:title) { 'all_opts' }
    let(:params) do
      {
        cert: '/tmp/foo.crt',
        address: '99.99.99.99',
        port: 11,
        ciphers: 'foocipher',
        client_cert: '/tmp/client_cert.crt',
        rewritelocation: 'some_rewrite'
      }
    end

    it do
      is_expected.to contain_concat__fragment('https_server-all_opts').with(
        content: %r{ListenHTTPS\n  Address 99.99.99.99}
      )
    end

    it do
      is_expected.to contain_concat__fragment('https_server-all_opts').with(
        content: %r{Port 11}
      )
    end

    it do
      is_expected.to contain_concat__fragment('https_server-all_opts').with(
        content: %r{Ciphers "foocipher"}
      )
    end

    it do
      is_expected.to contain_concat__fragment('https_server-all_opts').with(
        content: %r{ClientCert "/tmp/client_cert.crt"}
      )
    end

    it do
      is_expected.to contain_concat__fragment('https_server-all_opts').with(
        content: %r{RewriteLocation some_rewrite}
      )
    end
  end

  context 'with invalid cert' do
    let(:title) { 'bad_cert' }
    let(:params) do
      { cert: 'this_is_not_a_path' }
    end

    it { is_expected.not_to compile }
  end
end
