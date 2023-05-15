# Do not touch under this line
#Hash and download link

        $hash_full = "109d6da88eeba4e0f208033767279787"
        $download_hash_full = "https://huggingface.co/jcink0418/Arca/resolve/main/animefull-final-pruned.tar"


function Install-git-repo {
    if (Test-Path -Path stable-diffusion-webui) {
        Write-Host "stable-diffusion-webui ������ �����մϴ�"
        Write-Host "stable-diffusion-webui ������ �����ϰ� �ٽ� �������ּ���"
        Write-Host "`n"
        Write-Host "���α׷��� �����մϴ�"
        Write-Host "`n"
        cmd.exe /c pause
        exit
    }
    else {
        Write-Host "GIT �������丮 Ŭ���� �����մϴ�"
        Write-Host "`n"
        git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
        Write-Host "`n"
        Write-Host "`n"
    }
}


function ask-what-tar {
    Write-Host "`n"
    Write-Host "`n"
    Write-Host "<�ٿ���� �н����� �������ּ���>" -Foregroundcolor "Cyan"
    Write-Host "`n"
    Write-Host "0. �н����� ��ġ���� ���� : ��ġ �� �������� �н����� �߰��ؾ� �����̿� ����"
    Write-Host "1. animefull-final-pruned : �Ϲ����� ��Ȳ. �Ϲ� ~ R-18���� ������ �ϰ� ��밡��"
    Write-Host "`n"
    Write-Host "`n"
    $Select_mainmenu = Read-Host "��ȣ�� �Է��� �ֽñ� �ٶ��ϴ� "
    Write-Host "`n"    
    Write-Host "`n"
    switch ($Select_mainmenu)
    {
        '0' {
            skip-model-download
        }
        '1' {
            download-full-tar
        }
        
        default {
            Write-Host "`n"
            Write-Host "`n"
            Write-Host "���ð��� �����ϴ� �ٽ� �������ֽñ� �ٶ��ϴ�" -Foregroundcolor "Green"
            Start-Sleep -Seconds 1.5
            ask-what-tar
        }
    }
}

function skip-model-download {
    Write-Host ""
    Write-Host "�н��� �� VAE ��ġ�� �����մϴ�"
    Write-Host "�н����� ���� ������ ��ġ �� �н����� ���ٴ� ������ ��ϴ�"
    Write-Host "�������� ���ϴ� �н����� �޾Ƽ� ��ġ �� ����Ͻñ� �ٶ��ϴ�"
    Write-Host ""
}


function download-full-tar {
    if (Test-Path -Path animefull-final-pruned.tar) {
        Write-Host "animefull-final-pruned.tar�� �̹� �����մϴ�"
        Write-Host "���ϰ˻縦 �����մϴ�"
        Write-Host "`n"
        $hash = (CertUtil -hashfile animefull-final-pruned.tar MD5)[1] -replace " ",""
        $hash_full = $hash_full
        $download_hash_full = $download_hash_full
        Write-Host $hash
        Write-Host "`n"
        if ($hash -eq $hash_full) {
            Write-Host "�ؽ����� ��ġ�մϴ�."
            Write-Host "���� �ٿ�ε带 �����մϴ�"
            Write-Host "`n"
        }
        elseif ($hash -ne $hash_full) {
            Write-Host "�ؽ����� �ٸ��ϴ�!"
            Write-Host "`n"
            Write-Host "����:"$hash_full
            Write-Host "����:"$hash
            Write-Host "`n"
            Write-Host "���� ���� �� �ٿ�ε带 ������մϴ�"
            Write-Host "`n"
            Write-Host "[���� ����]`n  ���ϸ�: animefull-final-pruned.tar`n  ��  ��: 4.80GB"
            Write-Host "`n"
            del animefull-final-pruned.tar
            Invoke-WebRequest -Uri $download_hash_full -OutFile 'animefull-final-pruned.tar'
            Write-Host "���� �ٿ�ε尡 �Ϸ�Ǿ����ϴ�"
            Write-Host "`n"
        }
        }
        else {
            Write-Host "������ �������� �ʽ��ϴ�."
            Write-Host "���� �ٿ�ε带 �����մϴ�."
            Write-Host "`n"
            Write-Host "[���� ����]`n  ���ϸ�: animefull-final-pruned.tar`n  ��  ��: 4.80GB"
            Write-Host "`n"
            Invoke-WebRequest -Uri $download_hash_full -OutFile 'animefull-final-pruned.tar'
            Write-Host "���� �ٿ�ε尡 �Ϸ�Ǿ����ϴ�"
            Write-Host "`n"

        }
    unzip-full-tar
}



function install-settings {
    Write-Host "Settings.tar�� �ٿ�ε� �մϴ�"
    Invoke-WebRequest -Uri "https://huggingface.co/jcink0418/Arca/resolve/main/Settings.tar" -OutFile 'Settings.tar'
    Write-Host "Settings.tar �������� �մϴ�"
    Write-Host "`n"
    tar -zxvf .\Settings.tar -C .\
    Write-Host "`n"
    Write-Host "`n"
}


function install-addon {
    Write-Host "`n"
    Write-Host "`n"
    Write-Host "�ֵ�� ��ġ�� �����մϴ�."
    Write-Host "`n"
    Write-Host "[���� ����� �ֵ��]"
    Write-Host "  - ���� ��ũ��Ʈ"
    Write-Host "  - ���ϵ�ī�� �±�"
    Write-Host "  - �̹��� ������"
    Write-Host "  - �ڵ� �±��ۼ�"
    Write-Host "  - �ѱ���ġ"

    $title    = 'Ȯ��'
    $question = '�ֵ�� ��ġ�� �����Ͻðڽ��ϱ�?'
    $choices  = '&Y - ��', '&N - �ƴϿ�'
    
    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        Write-Host "`n"
        Write-Host "`n"
        Write-Host "�ֵ�� ��ġ�� �����մϴ�."
        Write-Host "`n"
        Write-Host "���� ��ũ��Ʈ ��ġ�� �����մϴ�"
        git clone "https://github.com/mkco5162/AI-WEBUI-scripts-Random" stable-diffusion-webui/extensions/AI-WEBUI-scripts-Random
        git -C stable-diffusion-webui/extensions/AI-WEBUI-scripts-Random fetch
        Write-Host "`n"
        Write-Host "���̳��� ������Ʈ ��ġ�� �����մϴ�."
        git clone "https://github.com/adieyal/sd-dynamic-prompts" stable-diffusion-webui/extensions/sd-dynamic-prompts
        git -C stable-diffusion-webui/extensions/sd-dynamic-prompts fetch
        Write-Host "`n"
        Write-Host "�ڵ� �±׿ϼ� ��ġ�� �����մϴ�."
        git clone "https://github.com/DominikDoom/a1111-sd-webui-tagcomplete" stable-diffusion-webui/extensions/tag-autocomplete
        git -C stable-diffusion-webui/extensions/tag-autocomplete fetch
        Write-Host "`n"
        Write-Host "�̹��� ������ ��ġ�� �����մϴ�."
        git clone "https://github.com/yfszzx/stable-diffusion-webui-images-browser" stable-diffusion-webui/extensions/stable-diffusion-webui-images-browser
        git -C stable-diffusion-webui/extensions/stable-diffusion-webui-images-browser fetch
        Write-Host "`n"
        Write-Host "�ѱ���ġ ��ġ�� �����մϴ�."
        git clone "https://github.com/36DB/stable-diffusion-webui-localization-ko_KR.git" stable-diffusion-webui/extensions/stable-diffusion-webui-localization-ko_KR
        git -C stable-diffusion-webui/extensions/stable-diffusion-webui-localization-ko_KR fetch
        Write-Host "`n"

    } else {
        Write-Host "`n"
        Write-Host "�ֵ�� ��ġ�� �����մϴ�."
        Write-Host "`n"
    }
}


function make-bat {
    Write-Host "����� ������ �����մϴ�"
    Write-Host "`n"
    Write-Host "`n"
    Set-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx �̻�).bat' '@echo off'
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx �̻�).bat' ''
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx �̻�).bat' 'set PYTHON='
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx �̻�).bat' 'set GIT='
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx �̻�).bat' 'set VENV_DIR='
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx �̻�).bat' 'set COMMANDLINE_ARGS=--xformers --deepdanbooru --autolaunch'
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx �̻�).bat' ''
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx �̻�).bat' 'call webui.bat'


    Set-content '.\stable-diffusion-webui\webui-user-������.bat' '@echo off'
    Add-content '.\stable-diffusion-webui\webui-user-������.bat' ''
    Add-content '.\stable-diffusion-webui\webui-user-������.bat' 'set PYTHON='
    Add-content '.\stable-diffusion-webui\webui-user-������.bat' 'set GIT='
    Add-content '.\stable-diffusion-webui\webui-user-������.bat' 'set VENV_DIR='
    Add-content '.\stable-diffusion-webui\webui-user-������.bat' 'set COMMANDLINE_ARGS=--skip-torch-cuda-test --no-half --precision=full --lowvram --deepdanbooru --autolaunch'
    Add-content '.\stable-diffusion-webui\webui-user-������.bat' ''
    Add-content '.\stable-diffusion-webui\webui-user-������.bat' 'call webui.bat'


    Set-content '.\stable-diffusion-webui\webui-user.bat' '@echo off'
    Add-content '.\stable-diffusion-webui\webui-user.bat' ''
    Add-content '.\stable-diffusion-webui\webui-user.bat' 'set PYTHON='
    Add-content '.\stable-diffusion-webui\webui-user.bat' 'set GIT='
    Add-content '.\stable-diffusion-webui\webui-user.bat' 'set VENV_DIR='
    Add-content '.\stable-diffusion-webui\webui-user.bat' 'set COMMANDLINE_ARGS=--deepdanbooru --autolaunch'
    Add-content '.\stable-diffusion-webui\webui-user.bat' ''
    Add-content '.\stable-diffusion-webui\webui-user.bat' 'call webui.bat'

}

function run {
    Write-Host "`n"
    Write-Host "WEB UI ��ġ �� ������ �����մϴ�."
    Write-Host "Torch �� Torchvision��Ű���� ��ġ�� �ð��� ���� �ҿ�Ǵ� �������� ��ٷ��ּ���"
    Write-Host "`n"
    Write-Host "`n"
    Write-Host "���� ���ට ���ʹ� " -nonewline; Write-Host "stable-diffusion-webui ����" -ForegroundColor "Cyan" -nonewline; Write-Host " �ȿ� �ִ�" -nonewline; Write-Host " webui-user.bat" -ForegroundColor "Cyan" -nonewline; Write-Host "���� �������ֽñ� �ٶ��ϴ�."
    cd stable-diffusion-webui
    cmd.exe /c '.\webui-user.bat'
}

Write-Host "Version: 0.66.2"
Write-Host "WEB UI ��ġ �� �н����� ������ �����մϴ�."
Write-Host "`n"
cmd.exe /c pause
Write-Host "`n"
Install-git-repo
ask-what-tar  �� ���� skip
install-settings
install-addon
make-bat
run
cmd.exe /c pause