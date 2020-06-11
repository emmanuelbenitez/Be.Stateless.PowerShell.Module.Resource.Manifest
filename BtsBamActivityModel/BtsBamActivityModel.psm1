#region Copyright & License

# Copyright © 2012 - 2020 François Chabot
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#endregion

Set-StrictMode -Version Latest

function New-BamActivityModel {
    [CmdletBinding()]
    [OutputType([PSCustomObject[]])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript( { $_ | Test-Path -PathType Leaf } )]
        [psobject[]]
        $Path,

        [Parameter(Mandatory = $false)]
        [ValidateScript( { $_ -is [bool] -or $_ -is [ScriptBlock] })]
        [ValidateNotNullOrEmpty()]
        [psobject]
        $Condition = $true,

        [Parameter(Mandatory = $false)]
        [switch]
        $PassThru
    )
    Resolve-ActionPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    $arguments = @{
        Resource  = 'BamActivityModels'
        Path      = $Path | Resolve-Path | Select-Object -ExpandProperty ProviderPath
        Condition = $Condition
    }
    New-Item @arguments -PassThru:$PassThru
}

Import-Module -Name $PSScriptRoot\..\Resource
Set-Alias -Name BamActivityModel -Value New-BamActivityModel