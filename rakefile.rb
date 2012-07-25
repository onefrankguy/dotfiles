#!/usr/bin/env ruby

require 'rake'

desc 'Install dotfiles'
task :install do
  linkables = Dir.glob('*/**{.symlink}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV['HOME']}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}"
        print "What do you want to do?"
        print " [s]kip, [S]kip all"
        print " [o]verwrite, [O]overate all"
        print " [b]ackup, [B]ackup all"
        puts "\n"

        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'O' then overwrite_all = true
        when 'b' then backup = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end

      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end

    `ln -s "$PWD/#{linkable}" "#{target}"`
  end
end

desc 'Uninstall dotfiles'
task :uninstall do
  Dir.glob('**/*.symlink').each do |linkable|
    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV['HOME']}/.#{file}"
    FileUtils.rm(target) if File.symlink?(target)
    if File.exists?("#{ENV['HOME']}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
    end
  end
end
