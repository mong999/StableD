# Do not touch under this line
#Hash and download link

        $hash_full = "109d6da88eeba4e0f208033767279787"
        $download_hash_full = "https://huggingface.co/jcink0418/Arca/resolve/main/animefull-final-pruned.tar"


function Install-git-repo {
    if (Test-Path -Path stable-diffusion-webui) {
        Write-Host "stable-diffusion-webui 폴더가 존재합니다"
        Write-Host "stable-diffusion-webui 폴더를 삭제하고 다시 실행해주세요"
        Write-Host "`n"
        Write-Host "프로그램을 종료합니다"
        Write-Host "`n"
        cmd.exe /c pause
        exit
    }
    else {
        Write-Host "GIT 레포지토리 클론을 시작합니다"
        Write-Host "`n"
        git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
        Write-Host "`n"
        Write-Host "`n"
    }
}


function ask-what-tar {
    Write-Host "`n"
    Write-Host "`n"
    Write-Host "<다운받을 학습모델을 선택해주세요>" -Foregroundcolor "Cyan"
    Write-Host "`n"
    Write-Host "0. 학습모델을 설치하지 않음 : 설치 후 수동으로 학습모델을 추가해야 정상이용 가능"
    Write-Host "1. animefull-final-pruned : 일반적인 상황. 일반 ~ R-18까지 광범위 하게 사용가능"
    Write-Host "`n"
    Write-Host "`n"
    $Select_mainmenu = Read-Host "번호를 입력해 주시기 바랍니다 "
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
            Write-Host "선택값이 없습니다 다시 선택해주시기 바랍니다" -Foregroundcolor "Green"
            Start-Sleep -Seconds 1.5
            ask-what-tar
        }
    }
}

function skip-model-download {
    Write-Host ""
    Write-Host "학습모델 및 VAE 설치를 생략합니다"
    Write-Host "학습모델이 없기 때문에 설치 후 학습모델이 없다는 에러가 뜹니다"
    Write-Host "수동으로 원하는 학습모델을 받아서 설치 후 사용하시기 바랍니다"
    Write-Host ""
}


function download-full-tar {
    if (Test-Path -Path animefull-final-pruned.tar) {
        Write-Host "animefull-final-pruned.tar이 이미 존재합니다"
        Write-Host "파일검사를 진행합니다"
        Write-Host "`n"
        $hash = (CertUtil -hashfile animefull-final-pruned.tar MD5)[1] -replace " ",""
        $hash_full = $hash_full
        $download_hash_full = $download_hash_full
        Write-Host $hash
        Write-Host "`n"
        if ($hash -eq $hash_full) {
            Write-Host "해쉬값이 일치합니다."
            Write-Host "파일 다운로드를 생략합니다"
            Write-Host "`n"
        }
        elseif ($hash -ne $hash_full) {
            Write-Host "해쉬값이 다릅니다!"
            Write-Host "`n"
            Write-Host "정상:"$hash_full
            Write-Host "현재:"$hash
            Write-Host "`n"
            Write-Host "파일 삭제 후 다운로드를 재시작합니다"
            Write-Host "`n"
            Write-Host "[파일 정보]`n  파일명: animefull-final-pruned.tar`n  용  량: 4.80GB"
            Write-Host "`n"
            del animefull-final-pruned.tar
            Invoke-WebRequest -Uri $download_hash_full -OutFile 'animefull-final-pruned.tar'
            Write-Host "파일 다운로드가 완료되었습니다"
            Write-Host "`n"
        }
        }
        else {
            Write-Host "파일이 존재하지 않습니다."
            Write-Host "파일 다운로드를 시작합니다."
            Write-Host "`n"
            Write-Host "[파일 정보]`n  파일명: animefull-final-pruned.tar`n  용  량: 4.80GB"
            Write-Host "`n"
            Invoke-WebRequest -Uri $download_hash_full -OutFile 'animefull-final-pruned.tar'
            Write-Host "파일 다운로드가 완료되었습니다"
            Write-Host "`n"

        }
    unzip-full-tar
}



function install-settings {
    Write-Host "Settings.tar를 다운로드 합니다"
    Invoke-WebRequest -Uri "https://huggingface.co/jcink0418/Arca/resolve/main/Settings.tar" -OutFile 'Settings.tar'
    Write-Host "Settings.tar 압축해제 합니다"
    Write-Host "`n"
    tar -zxvf .\Settings.tar -C .\
    Write-Host "`n"
    Write-Host "`n"
}


function install-addon {
    Write-Host "`n"
    Write-Host "`n"
    Write-Host "애드온 설치를 시작합니다."
    Write-Host "`n"
    Write-Host "[현재 적용된 애드온]"
    Write-Host "  - 랜덤 스크립트"
    Write-Host "  - 와일드카드 태그"
    Write-Host "  - 이미지 브라우저"
    Write-Host "  - 자동 태그작성"
    Write-Host "  - 한글패치"

    $title    = '확인'
    $question = '애드온 설치를 진행하시겠습니까?'
    $choices  = '&Y - 예', '&N - 아니요'
    
    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        Write-Host "`n"
        Write-Host "`n"
        Write-Host "애드온 설치를 시작합니다."
        Write-Host "`n"
        Write-Host "랜덤 스크립트 설치를 시작합니다"
        git clone "https://github.com/mkco5162/AI-WEBUI-scripts-Random" stable-diffusion-webui/extensions/AI-WEBUI-scripts-Random
        git -C stable-diffusion-webui/extensions/AI-WEBUI-scripts-Random fetch
        Write-Host "`n"
        Write-Host "다이나믹 프롬프트 설치를 시작합니다."
        git clone "https://github.com/adieyal/sd-dynamic-prompts" stable-diffusion-webui/extensions/sd-dynamic-prompts
        git -C stable-diffusion-webui/extensions/sd-dynamic-prompts fetch
        Write-Host "`n"
        Write-Host "자동 태그완성 설치를 시작합니다."
        git clone "https://github.com/DominikDoom/a1111-sd-webui-tagcomplete" stable-diffusion-webui/extensions/tag-autocomplete
        git -C stable-diffusion-webui/extensions/tag-autocomplete fetch
        Write-Host "`n"
        Write-Host "이미지 브라우저 설치를 시작합니다."
        git clone "https://github.com/yfszzx/stable-diffusion-webui-images-browser" stable-diffusion-webui/extensions/stable-diffusion-webui-images-browser
        git -C stable-diffusion-webui/extensions/stable-diffusion-webui-images-browser fetch
        Write-Host "`n"
        Write-Host "한글패치 설치를 시작합니다."
        git clone "https://github.com/36DB/stable-diffusion-webui-localization-ko_KR.git" stable-diffusion-webui/extensions/stable-diffusion-webui-localization-ko_KR
        git -C stable-diffusion-webui/extensions/stable-diffusion-webui-localization-ko_KR fetch
        Write-Host "`n"

    } else {
        Write-Host "`n"
        Write-Host "애드온 설치를 생략합니다."
        Write-Host "`n"
    }
}


function make-bat {
    Write-Host "실행기 설정을 시작합니다"
    Write-Host "`n"
    Write-Host "`n"
    Set-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx 이상).bat' '@echo off'
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx 이상).bat' ''
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx 이상).bat' 'set PYTHON='
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx 이상).bat' 'set GIT='
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx 이상).bat' 'set VENV_DIR='
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx 이상).bat' 'set COMMANDLINE_ARGS=--xformers --deepdanbooru --autolaunch'
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx 이상).bat' ''
    Add-content '.\stable-diffusion-webui\webui-user-xformers(RTX-1xxx 이상).bat' 'call webui.bat'


    Set-content '.\stable-diffusion-webui\webui-user-저사양용.bat' '@echo off'
    Add-content '.\stable-diffusion-webui\webui-user-저사양용.bat' ''
    Add-content '.\stable-diffusion-webui\webui-user-저사양용.bat' 'set PYTHON='
    Add-content '.\stable-diffusion-webui\webui-user-저사양용.bat' 'set GIT='
    Add-content '.\stable-diffusion-webui\webui-user-저사양용.bat' 'set VENV_DIR='
    Add-content '.\stable-diffusion-webui\webui-user-저사양용.bat' 'set COMMANDLINE_ARGS=--skip-torch-cuda-test --no-half --precision=full --lowvram --deepdanbooru --autolaunch'
    Add-content '.\stable-diffusion-webui\webui-user-저사양용.bat' ''
    Add-content '.\stable-diffusion-webui\webui-user-저사양용.bat' 'call webui.bat'


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
    Write-Host "WEB UI 설치 및 실행을 시작합니다."
    Write-Host "Torch 와 Torchvision패키지는 설치에 시간이 오래 소요되니 끄지말고 기다려주세요"
    Write-Host "`n"
    Write-Host "`n"
    Write-Host "다음 실행때 부터는 " -nonewline; Write-Host "stable-diffusion-webui 폴더" -ForegroundColor "Cyan" -nonewline; Write-Host " 안에 있는" -nonewline; Write-Host " webui-user.bat" -ForegroundColor "Cyan" -nonewline; Write-Host "으로 실행해주시기 바랍니다."
    cd stable-diffusion-webui
    cmd.exe /c '.\webui-user.bat'
}

Write-Host "Version: 0.66.2"
Write-Host "WEB UI 설치 및 학습파일 적용을 시작합니다."
Write-Host "`n"
cmd.exe /c pause
Write-Host "`n"
Install-git-repo
ask-what-tar  모델 선택 skip
install-settings
install-addon
make-bat
run
cmd.exe /c pause