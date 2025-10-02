# Scripts de Backup Automatizado (PowerShell)

Este repositório contém três scripts em **PowerShell** para automação de backups de banco de dados, máquinas virtuais (VirtualBox) e diretórios.  
O objetivo é facilitar a criação de rotinas de backup e permitir que sejam agendadas via **Agendador de Tarefas do Windows**.

---

## 📌 Scripts incluídos

### 1. BACKUP_BD_REMOTO.ps1
Faz o backup de um banco de dados MySQL remoto utilizando o `mysqldump`.

**Configurações principais:**
- Ajuste as variáveis:
  ```powershell
  $Database = "nome_do_banco"
  $User = "usuario_do_banco"
  $Password = "senha_do_banco"
  $DbHost = "db_host"
  $OutputPath = "C:\\Diretorio_onde\\o_backup\\sera_salvo\\backup_yyyy-MM-dd_HH-mm-ss.sql"
  ```
- Gera um arquivo `.sql` com **data e hora** no nome.

**Pré-requisitos:**
- MySQL Client instalado e no **PATH** do sistema.
- Permissão de acesso ao banco de dados remoto.

---

### 2. BACKUP_VM_VIRTUALBOX.ps1
Realiza o backup de uma máquina virtual do VirtualBox no formato `.ova`.

**O que o script faz:**
1. Desliga a VM.
2. Limpa arquivos antigos no diretório de backup.
3. Exporta a VM para um arquivo `.ova` nomeado com data e hora.
4. Religa a VM em modo **headless**.

**Configurações principais:**
- Ajuste o nome da VM e o diretório de backup:
  ```powershell
  $vmName = "nome_da_sua_vm"
  $backupDir = "C:\Caminho\Para\Diretorio\De\Backup"
  ```
- Caminho padrão do VBoxManage:
  ```
  C:\Program Files\Oracle\VirtualBox\VBoxManage.exe
  ```

**Pré-requisitos:**
- VirtualBox instalado e acessível via `VBoxManage.exe`.

---

### 3. BACKUP_DIRETORIO.ps1
Compacta um diretório de backup em um arquivo `.rar` utilizando o **WinRAR**.

**O que o script faz:**
1. Limpa o diretório de destino antes de gerar o novo arquivo.
2. Cria um arquivo `.rar` com nome `BKP_yyyy-MM-dd.rar`.
3. Exibe o progresso da compactação no console.

**Configurações principais:**
- Ajuste os caminhos:
  ```powershell
  $fonte = "caminho\para\diretorio\de\backup"
  $destino = "caminho\para\diretorio\de\destino"
  $winrar = "C:\Program Files\WinRAR\rar.exe"
  ```

**Pré-requisitos:**
- WinRAR instalado (e caminho ajustado no script).

---

## ⚙️ Como executar manualmente
Abra o PowerShell e rode:
```powershell
powershell.exe -ExecutionPolicy Bypass -File "C:\caminho\do\script\NOME_DO_SCRIPT.ps1"
```

---

## 📅 Como agendar via Agendador de Tarefas (Windows Task Scheduler)

1. Abra o **Agendador de Tarefas** (Task Scheduler).
2. Clique em **Criar Tarefa**.
3. Na aba **Geral**:
   - Dê um nome descritivo, ex: `Backup Banco de Dados`.
   - Marque **Executar com privilégios mais altos**.
4. Na aba **Disparadores**:
   - Configure a periodicidade (diário, semanal, etc).
5. Na aba **Ações**:
   - Clique em **Nova...**
   - Programa/script:  
     ```
     powershell.exe
     ```
   - Adicione argumentos:  
     ```
     -ExecutionPolicy Bypass -File "C:\caminho\do\script\NOME_DO_SCRIPT.ps1"
     ```
6. Na aba **Condições** e **Configurações**, ajuste conforme necessário (ex: só executar se estiver conectado à energia).
7. Clique em **OK** para salvar.

---

## 🚀 Sugestões de uso
- **Backup diário** do banco de dados (`BACKUP_BD_REMOTO.ps1`) à noite.
- **Backup semanal** da VM (`BACKUP_VM_VIRTUALBOX.ps1`).
- **Compactação diária** de diretórios (`BACKUP_DIRETORIO.ps1`).

---

✍️ Autor: *João Vitor Gomes*  
📌 Este repositório foi criado para automatizar e simplificar rotinas de backup no Windows.
